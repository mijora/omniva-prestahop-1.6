{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
*         DISCLAIMER   *
* *************************************** */
/* Do not edit or add to this file if you wish to upgrade Prestashop to newer
* versions in the future.
* ****************************************************
*}
{addJsDef omnivaltdelivery_controller=$link->getModuleLink('omnivaltshipping', 'ajax')}
<div id="omnivalt_parcel_terminal_carrier_details" style="display: block; margin-top: 10px;">
  <select class="select2" name="omnivalt_parcel_terminal" style="max-width:400px;">{$parcel_terminals}</select>
  <script type="text/javascript">
    {literal}
      $(document).ready(function(){
        omnivaltDelivery.init();
        $('.select2').select2();
      })
    {/literal}
    var omnivalt_parcel_terminal_carrier_id = {$omnivalt_parcel_terminal_carrier_id}
  </script>
  <style>
    {literal}
      #omnivalt_parcel_terminal_carrier_details{ margin-bottom: 5px }
    {/literal}
  </style>
  {if isset($omniva_api_key) and $omniva_api_key != false }
    <script language="Javascript"  type="text/javascript">
      var locations = {$terminals_list};
      var map_country = "{$map_country}";
      var select_terminal = "{l s='Pasirinkti terminalą'}";
      var text_search_placeholder = "{l s='įveskite adresą'}";
    </script>
    <script defer type="text/javascript" src="{$mapEsri}" ></script>
    <button type="button" id="show-omniva-map" class="btn btn-basic btn-sm omniva-btn ">
      <i id="show-omniva-map" class="fa fa-map-marker-alt fa-lg" aria-hidden="true"></i>
    </button>
  {/if}
</div>
