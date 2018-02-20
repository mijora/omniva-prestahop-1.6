<style>.tab-content { border: 1px solid #ddd; padding: 10px; }</style>
<div class="panel col-lg-12">
<div class="panel-heading">
<h4>{l s='Omniva orders' mod='omnivaltshipping'} ({$manifestNum})</h4>

</div>

<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" title="{l s='Kurjerio iškvietimas' mod='omnivaltshipping'}" style="position:absolute; right:10px"><i class="fa fa fa-send-o"></i>{l s='Kurjerio iškvietimas' mod='omnivaltshipping'}</button>

<ul class="nav nav-tabs">
    <li class="active"><a href="#tab-general" data-toggle="tab">{l s='New orders' mod='omnivaltshipping'}</a></li>
    <li><a href="#tab-data" data-toggle="tab">{l s='Awaiting' mod='omnivaltshipping'}</a></li>
    <li><a href="#tab-sent-orders" data-toggle="tab">{l s='Completed' mod='omnivaltshipping'}</a></li>
</ul>
<div class="tab-content">
    <!-- New Orders -->
    <div class="tab-pane active" id="tab-general">
    {if $newOrders != null && $page == 1}
    <h4 style="display: inline:block;vertical-align: baseline;">{l s='New orders' mod='omnivaltshipping'}</h4>

    <table class="table order" >
	  <thead>
		<tr class="nodrag nodrop">
            <th width='5%'>
				<span class="title_box"><input type = "checkbox" id = "select-all"/></span>
			</th>
			<th width='5%'>
				<span class="title_box active">{l s='Id' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Customer' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Tracking' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Update date' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Total' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Labels' mod='omnivaltshipping'}</span>
			</th>
		</tr>
	</thead>
    <tbody>
	{assign var=result value=''}
    {foreach from=$newOrders key=myId item=i}
                        <tr>
                            <td><input type = "checkbox" class = "selected-orders" value = "{$i.id_order}" /></td>
                            <td>{$i.id_order}</td>
                            <td><a href="{$orderLink}&id_order={$i.id_order}">{$i.firstname} {$i.lastname}</td>
                            <td>{$i.tracking_number}</td>
                            <td>{$i.date_upd}</td>
                            <td>{$i.total_paid}</td>
                            <td>
								<a href="{$labels}&order_ids={$i.id_order}" class="btn btn-success btn-xs" target="_blank">{l s='Labels' mod='omnivaltshipping'}</a>
								<!--<a href="{$manifestLink}&order_ids={$i.id_order}" class="btn btn-success btn-xs" target="_blank">{l s='Manifest' mod='omnivaltshipping'}</a>-->
								{if $i.tracking_number == null}
								<a href="{$orderSkip}{$i.id_order}" class="btn btn-danger btn-xs">{l s='Skip' mod='omnivaltshipping'}</a>
								{/if}
								{* $i.omnivalt_manifest *}
							</td>
							{$result = "{$result},{$i.id_order}"}
							{$manifest = $i.omnivalt_manifest}
                        </tr>
    {/foreach}
                            </tbody>
                        </table>
			<a href="{$manifestAll}&order_ids={$result}&type=new" data-url = "{$manifestAll}&type=new&order_ids=" class="btn btn-default btn-xs action-call" target='_blank'>{l s='Manifest' mod='omnivaltshipping'}</a>
			<a href="{$labels}&order_ids={$result}" data-url = "{$labels}&order_ids=" class="btn btn-default btn-xs action-call" target='_blank'>{l s='Labels' mod='omnivaltshipping'}</a>
		
						<br/><hr/><br/>
    {else}
    <br>{l s='Užsakymų nėra' mod='omnivaltshipping'}
    {/if}
    </div> 
    <!--/New Orders -- Skipped Orders -->
    <div class="tab-pane" id="tab-data">
    {if $skippedOrders != null}
    <h4 style="display: inline:block;vertical-align: baseline;">{l s='Skipped orders' mod='omnivaltshipping'}</h4>

    <table class="table order" >
	  <thead>
		<tr class="nodrag nodrop">
			<th width='5%'>
				<span class="title_box active">{l s='Id' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Customer' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Tracking' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Update date' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Total' mod='omnivaltshipping'}</span>
			</th>
			<th width='15%'>
				<span class="title_box">{l s='Labels' mod='omnivaltshipping'}</span>
			</th>
		</tr>
	</thead>
    <tbody>
    {foreach from=$skippedOrders key=myId item=i}
                        <tr>
                            <td>{$i.id_order}</td>
                            <td><a href="{$orderLink}&id_order={$i.id_order}">{$i.firstname} {$i.lastname}</td>
                            <td>{$i.tracking_number}</td>
                            <td>{$i.date_upd}</td>
                            <td>{$i.total_paid}</td>
                            <td>
								{if $i.tracking_number == null}
								<a href="{$cancelSkip}{$i.id_order}" class="btn btn-danger btn-xs">{l s='Add to manifest' mod='omnivaltshipping'}</a>
								{/if}
								{* $i.omnivalt_manifest *}
							</td>
                        </tr>
    {/foreach}
                            </tbody>
                        </table>		
						<br/><hr/><br/>
    {else}<br>
    {l s='Užsakymų nėra' mod='omnivaltshipping'}
    {/if}
    </div>
    <!--/ Skipped Orders -->
    <!-- Completed Orders -->
    <div class="tab-pane" id="tab-sent-orders">
    {if isset($orders[0]['omnivalt_manifest'])}		
        {assign var=hasOrder value=$orders[0]['omnivalt_manifest']+1}
    {else}
        {assign var=hasOrder value=null}
        {* assign var=hasOrder = 'null' *}
    {/if}
    {if $orders != null}

        <h4>{l s='Generated' mod='omnivaltshipping'}</h4>
         {assign var=newPage value=null}
		 {assign var=result value=''}
         {foreach from=$orders key=myId item=i}
			{if (isset($manifestOrd) && $i.omnivalt_manifest != $manifestOrd) OR $newPage ==null}
                    {assign var=newPage value=true}
				</table>
				{if $myId !=0}
                <br/>
				<a href="{$manifestAll}&order_ids={$result}" class="btn btn-default btn-xs" target='_blank'>{l s='Manifest' mod='omnivaltshipping'}</a>
				<a href="{$labels}&order_ids={$result}" class="btn btn-default btn-xs" target='_blank'>{l s='Labels' mod='omnivaltshipping'}</a><br>
				{assign var=result value=''}
				{/if}
				<br>
				<table class="table order" >
				<thead>
					<tr class="nodrag nodrop">
                        <th width='5%'>
                            <span class="title_box active">{l s='Id' mod='omnivaltshipping'}</span>
                        </th>
                        <th width='15%'>
                            <span class="title_box">{l s='Customer' mod='omnivaltshipping'}</span>
                        </th>
                        <th width='15%'>
                            <span class="title_box">{l s='Tracking' mod='omnivaltshipping'}</span>
                        </th>
                        <th width='15%'>
                            <span class="title_box">{l s='Update date' mod='omnivaltshipping'}</span>
                        </th>
                        <th width='15%'>
                            <span class="title_box">{l s='Total' mod='omnivaltshipping'}</span>
                        </th>
                        <th width='15%'>
                            <span class="title_box">{l s='Labels' mod='omnivaltshipping'}</span>
                        </th>
					</tr>
				</thead>
				<tbody>
			{/if}
                        <tr>
                            <td>{$i.id_order}</td>
                            <td><a href="{$orderLink}&id_order={$i.id_order}">{$i.firstname} {$i.lastname}</td>
                            <td>{$i.tracking_number}</td>
                            <td>{$i.date_upd}</td>
                            <td>{$i.total_paid}</td>
                            <td>
								<a href="{$labels}&order_ids={$i.id_order}" class="btn btn-success btn-xs" target="_blank">{l s='Labels' mod='omnivaltshipping'}</a>
							{* $i.omnivalt_manifest *}
							</td>
                        {$result = "{$result},{$i.id_order}"}
                        {$manifestOrd = $i.omnivalt_manifest}
                        </tr>
                        {/foreach}
                    {/if}
                {if $orders != null}
                </tbody>
                </table>
             <br>
             <a href="{$manifestAll}&order_ids={$result}" class="btn btn-default btn-xs" target='_blank'>{l s='Manifest' mod='omnivaltshipping'}</a>
             <a href="{$labels}&order_ids={$result}" class="btn btn-default btn-xs" target='_blank'>{l s='Labels' mod='omnivaltshipping'}</a><br>
             <div class="text-center">
             {$pagination}</div>
            {/if}
    </div>
    <!--/ Completed Orders -->
</div>

<!-- Modal Carier call-->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
    <form class="form-horizontal">

      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">{l s='Baigiamoji siunta, kurjerio iškvietimas.' mod='omnivaltshipping'}</h4>
      </div>
      <div class="modal-body">
            <div class="alert alert-info">
                    <strong>Svarbu!</strong> {l s='Vėliausias galimas kurjerio iškvietimas yra iki 15val. Vėliau iškvietus kurjerį negarantuojame, jog siunta bus paimta.' mod='omnivaltshipping'}
                    <br />
                    <strong>{l s='Adresą ir kontaktinius duomenis' mod='omnivaltshipping'}</strong>  {l s='galima keisti Omnivalt modulio nustatymuose.' mod='omnivaltshipping'}
            </div>
            <h4>{l s='Siunčiami duomenys' mod='omnivaltshipping'}<h4>
            <b>{l s='Siuntėjas:' mod='omnivaltshipping'}</b> {$sender}<br>
            <b>{l s='Telefonas:' mod='omnivaltshipping'}</b> {$phone}<br>
            <b>{l s='Pašto kodas:' mod='omnivaltshipping'}</b> {$postcode}<br>
            <b>{l s='Adresas:' mod='omnivaltshipping'}</b> {$address}<br><br>
            <div id="alertList"></div>
      </div>
      <div class="modal-footer">
            <button type="submit"  id="requestOmnivaltQourier" class="btn btn-default">{l s='Siųsti' mod='omnivaltshipping'}</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">{l s='Atšaukti' mod='omnivaltshipping'}</button>
      </div>
    </form>
    </div>
  </div>
</div>
<!--/ Modal Carier call-->

<script>
$(document).ready(function(){
    $('.showall').hide();
    $('.pagination_next b').hide();
    $('.pagination_previous b').hide();
    $('#select-all').on('click',function(){
        var checked = $(this).prop('checked');
        $('.selected-orders').prop('checked',checked);
    });
    $('.action-call').on('click',function(e){
        //e.preventDefault();
        var ids = '';
        $('.selected-orders:checked').each(function(){
            ids += "," + $(this).val();
        });
        if (ids == ""){
            alert('Pasirinkite užsakymus');
            return false;
        } else {
            $(this).attr('href', $(this).data('url') + ids);
        }
            
    });
    /* Start courier call */
     $('#requestOmnivaltQourier').on('click', function(e) {
     e.preventDefault();
	$.ajax({
		url: '{$carrier_cal_url}',
		type: 'get',
        beforeSend: function() {
            $('#alertList').empty();
        },
		success: function(data) {
			//console.log(data);
            if(data == 'got_request'){
                $('#alertList').append('<div class="alert alert-success" id="remove2">\
                 <strong>{l s='Baigta!' mod='omnivaltshipping'}</strong> {l s='Pranešimas sėkmingai išsiųstas.' mod='omnivaltshipping'}\
                </div>');
            } else {
                $('#alertList').append('<div class="alert alert-danger" id="remove2">\
                 <strong>{l s='Deja!' mod='omnivaltshipping'}</strong> {l s='klaidingas atsakymas.' mod='omnivaltshipping'}\
                </div>');
            }

        setTimeout(function(){
            $('#remove2').remove();
            $('#myModal').modal('hide');
            //$('#alertList').empty();
            }, 3000);
                
		},
    		error: function(xhr, ajaxOptions, thrownError) {
			/* alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);*/
		}
	 });
    });
    /*/End of courier call */
    var params={};
window.location.search
  .replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str,key,value) {
    params[key] = value;
  }
);
if(params['tab'] == 'completed')
     $('[href="#tab-sent-orders"]').trigger('click');

//console.log(params);
});

</script>
