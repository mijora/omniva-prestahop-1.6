<?php
class AdminOmnivaOrdersController extends ModuleAdminController
{
    private $_carriers = '';
	private $_module = NULL;

		public function __construct()
		{
      $this->_carriers = Configuration::get('omnivalt_pt') . ',' . Configuration::get('omnivalt_c');
			$this->bootstrap = true;
            $this->name = 'AdminModList';
            //$this->table = 'order';
			$this->meta_title = $this->l('Omniva orders');
			parent::__construct();
			if(Tools::getValue('orderSkip') != null) {
				$this->skipOrder();
				exit();
			} else if (Tools::getValue('cancelSkip') != null) {
				$this->cancelSkip();
				exit();
			} else if(Tools::getValue('callCourier')) {
				$this->callCarrier();
				exit();
			} else if (Tools::getValue('installCntrAdminDone') != null) {
				$this->installController();
				exit();
			}
		}
	public function callcarrier() {
		$this->_module = new OmnivaltShipping();
		//$callCarrierReturn = $this->_module->call_omniva();
		$callCarrierReturn['status'] = true;
		if($callCarrierReturn['status'] == true)
			print'got_request';
		else 
			print'got_request_false';
	}
	public function initContent()
	{
		parent::initContent();

		$ordersCount = $this->ordersNumb();
		$perPage = 10;
		$pagesToShow = intval(ceil($ordersCount/$perPage));
		$page = 1;
		if(Tools::getValue('p') && Tools::getValue('p') != null)
			$page = intval(Tools::getValue('p'));
		if($page <=0 || $page >$pagesToShow)
			$page = 1;

		if($pagesToShow<=5) {
			$endGroup = $pagesToShow;
		} else {
			if($pagesToShow - $page >2){
				$endGroup = $page+2;
			} else {
				$endGroup = $pagesToShow;
			}
		}
		if($endGroup - 4 >0) {
			$startGroup = $endGroup -4;
		} else {
			$startGroup = 1;
		}

        $this->context->smarty->assign(array(
            'content2' => 'dsdd',
			'orders' => $this->getOrders($page-1, $perPage, $ordersCount),

			'sender' => Configuration::get('omnivalt_company'),
			'phone'	=> Configuration::get('omnivalt_phone'),
			'postcode'	=> Configuration::get('omnivalt_postcode'),
			'address'	=> Configuration::get('omnivalt_address'),
			'carrier_cal_url'	=> $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&callCourier=1',
			
			'skippedOrders' => $this->getSkippedOrders(),
			'newOrders' => $this->getNewOrders(),
			'orderLink' => $this->context->link->getAdminLink('AdminOrders', true).'&vieworder',
			'orderSkip' => $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&orderSkip=',
			'cancelSkip' => $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&cancelSkip=',
			'page'		=>$page,
			'manifestLink' => $this->context->link->getModuleLink("omnivaltshipping", "omnivaltadminajax", array("action"=>"bulkmanifests")),			
			
			'manifestAll' => $this->context->link->getModuleLink("omnivaltshipping", "omnivaltadminajax", array("action"=>"bulkmanifestsall")),			
			'labels' => $this->context->link->getModuleLink("omnivaltshipping", "omnivaltadminajax", array("action"=>"bulklabels")),			
			'manifestNum' => strval(Configuration::get('omnivalt_manifest')),
			'total' => $this->_listTotal,

			'nb_products' =>$ordersCount,	
			'products_per_page' =>$perPage,
			'pages_nb' => $pagesToShow,
			'prev_p' => (int)$page != 1 ? $page-1 : 1,
			'next_p' => (int)$page + 1 > $pagesToShow? $pagesToShow : $page + 1,
			'requestPage' => $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&tab=completed',
			'current_url' => $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&tab=completed',
			'requestNb' => $this->context->link->getAdminLink('AdminOmnivaOrders', true).'&tab=completed',
			'p' => $page,
			'n' => $perPage,
			'start' => $startGroup,
			'stop' => $endGroup,
					));
		$this->context->smarty->assign(
			array(
				'pagination' => $this->context->smarty->fetch(_PS_THEME_DIR_.'pagination.tpl'),
				'pagination_bottom' => $this->context->smarty->assign('paginationId', 'bottom')
				->fetch(_PS_THEME_DIR_.'pagination.tpl'),
			));
        $content = $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'omnivaltshipping/views/templates/admin/omnivaOrders.tpl');
        
               $this->context->smarty->assign(
                       array(
                           'content' => $this->content . $content,
                       )
			   );
			   
    }
    
	public function getOrders($page = 1, $perPage = 10, $total = 0) 
	{
		$newOrder = intval(Configuration::get('omnivalt_manifest'));
		$from = $page*$perPage;
        $orders = "SELECT * FROM "._DB_PREFIX_."orders a
		INNER JOIN "._DB_PREFIX_."customer oh ON a.id_customer = oh.id_customer
		LEFT JOIN "._DB_PREFIX_."order_carrier oc ON a.id_order = oc.id_order
		INNER JOIN "._DB_PREFIX_."cart k ON a.id_cart = k.id_cart AND k.id_carrier IN (" . $this->_carriers . ")
		WHERE k.omnivalt_manifest IS NOT NULL AND k.omnivalt_manifest<>".$newOrder."  AND k.omnivalt_manifest <> -1
		ORDER BY k.omnivalt_manifest DESC, a.id_order DESC
		LIMIT $perPage OFFSET $from";

        return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($orders);
	}

	public function getSkippedOrders()
	{
		$orders = "SELECT * FROM "._DB_PREFIX_."orders a
		INNER JOIN "._DB_PREFIX_."customer oh ON a.id_customer = oh.id_customer
		LEFT JOIN "._DB_PREFIX_."order_carrier oc ON a.id_order = oc.id_order
		INNER JOIN "._DB_PREFIX_."cart k ON a.id_cart = k.id_cart AND k.id_carrier IN (" . $this->_carriers . ")
		WHERE k.omnivalt_manifest IS NOT NULL AND k.omnivalt_manifest = -1
		ORDER BY k.omnivalt_manifest DESC, a.id_order DESC";

		return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($orders);
	}

	public function getNewOrders()
	{
		$newOrderNum = intval(Configuration::get('omnivalt_manifest'));
		$newOrder = "SELECT *FROM "._DB_PREFIX_."orders a
		INNER JOIN "._DB_PREFIX_."customer oh ON a.id_customer = oh.id_customer
		INNER JOIN "._DB_PREFIX_."order_carrier oc ON a.id_order = oc.id_order
		INNER JOIN "._DB_PREFIX_."cart k ON a.id_cart = k.id_cart AND k.id_carrier IN (" . $this->_carriers . ")
		WHERE k.omnivalt_manifest IS NULL OR k.omnivalt_manifest=".$newOrderNum."
		ORDER BY k.omnivalt_manifest DESC, a.id_order DESC";

		return Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($newOrder);		
	}

	public function ordersNumb()
	{
		$newOrder = intval(Configuration::get('omnivalt_manifest'));
		
				$ordersCount = "SELECT COUNT(*) FROM "._DB_PREFIX_."orders a
				INNER JOIN "._DB_PREFIX_."customer oh ON a.id_customer = oh.id_customer
				LEFT JOIN "._DB_PREFIX_."order_carrier oc ON a.id_order = oc.id_order
				INNER JOIN "._DB_PREFIX_."cart k ON a.id_cart = k.id_cart AND k.id_carrier IN (" . $this->_carriers . ")
				WHERE k.omnivalt_manifest IS NOT NULL AND k.omnivalt_manifest<>".$newOrder." AND k.omnivalt_manifest <> -1
				ORDER BY a.id_order DESC";

		$rowCount = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($ordersCount);
		return intval($rowCount[0]["COUNT(*)"]);
	}

	public function skipOrder()
    {
		if(Tools::getValue('orderSkip')) {
			$orderIds = intval(Tools::getValue('orderSkip'));
			if( $orderIds > 0) {
			$saveManifest = "UPDATE `ps_cart` 
			SET omnivalt_manifest = -1
			WHERE id_cart = (SELECT id_cart FROM ps_orders WHERE id_order = ".$orderIds.");";
			Db::getInstance(_PS_USE_SQL_SLAVE_)->execute($saveManifest);
			}
		}
		Tools::redirectAdmin(Context::getContext()->link->getAdminLink('AdminOmnivaOrders'));
		
    }

    public function cancelSkip()
    {
		if(Tools::getValue('cancelSkip')) {
			$orderIds = intval(Tools::getValue('cancelSkip'));
			if( $orderIds > 0) {
			$saveManifest = "UPDATE `ps_cart` 
			SET omnivalt_manifest = null
			WHERE id_cart = (SELECT id_cart FROM ps_orders WHERE id_order = ".$orderIds.");";
			Db::getInstance(_PS_USE_SQL_SLAVE_)->execute($saveManifest);
			}
		}
		Tools::redirectAdmin(Context::getContext()->link->getAdminLink('AdminOmnivaOrders'));	
	}
	
	public function installController()
	{
		$new_fields2 = 'ALTER TABLE `'._DB_PREFIX_ .'cart` ADD omnivalt_manifest VARCHAR(10) default NULL';
		DB::getInstance()->Execute($new_fields2 );

		$saveManifest = "UPDATE `ps_cart` 
		SET omnivalt_manifest = -1";
		DB::getInstance()->Execute($saveManifest );
		
		$name= $this->l('Omniva orders');
		$controllerName = 'AdminOmnivaOrders';
		$tab_admin_order_id = Tab::getIdFromClassName ('AdminShipping') ? Tab::getIdFromClassName ('AdminShipping') : Tab::getIdFromClassName ('Shipping');
		$tab = new Tab();
		$tab->class_name = $controllerName;
		$tab->id_parent = $tab_admin_order_id;
		$tab->module = $this->name;
		$languages = Language::getLanguages(false);
		foreach($languages as $lang){
			$tab->name[$lang['id_lang']] = $name;
		}
		$tab->save();

		Configuration::updateValue('omnivalt_manifest', 1);
		
	}
}