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

<!--  omnivalt_parcel_terminal_carrier [begin] -->
<script type="text/javascript">
    var omnivalt_parcel_terminal_carrier_id = {$omnivalt_parcel_terminal_carrier_id};
    var omnivalt_parcel_terminal_error = '{l s='Please select parcel terminal' mod='omnivaltshipping'}';
</script>
<!--  omnivalt_parcel_terminal_carrier [end] -->

{addJsDef omnivalt_parcel_terminal_carrier_id=$omnivalt_parcel_terminal_carrier_id}
{addJsDef omnivaltdelivery_controller=$link->getModuleLink('omnivaltshipping', 'ajax')}

{if isset($omniva_api_key) and $omniva_api_key != false}

<style>
{literal}
.modal {
    display: none;
    position: fixed;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
    -webkit-animation-name: fadeIn;
    -webkit-animation-duration: 0.4s;
    animation-name: fadeIn;
    animation-duration: 0.4s;
    z-index:20;
}
.omniva-modal-content {
    z-index:20;
    position:fixed;
    top: 10%;
    left: 15%;
    background-color: #fefefe;
    border-radius: 5px;
    width: 75%;
    height:80%;
    -webkit-animation-name: slideIn;
    -webkit-animation-duration: 0.4s;
    animation-name: slideIn;
    animation-duration: 0.4s;
}

.close {
    color: black;
    float: right;
    font-size: 28px;
    font-weight: bold;
    margin-right: -5px;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

.omniva-modal-header {
    padding: 4px 16px;
    color: black;
    height: 7%;
}

.omniva-modal-body {
    padding: 10px;
    height:92%;
}

.omniva-modal-footer {
    height: 6%;
    align-items: center;
}
@-webkit-keyframes slideIn {
    from {bottom: -300px; opacity: 0} 
    to {bottom: 0; opacity: 1}
}

@keyframes slideIn {
    from {bottom: -300px; opacity: 0}
    to {bottom: 0; opacity: 1}
}

@-webkit-keyframes fadeIn {
    from {opacity: 0} 
    to {opacity: 1}
}

@keyframes fadeIn {
    from {opacity: 0} 
    to {opacity: 1}
}

.btn-address {
    background-color: #E47A2E;
    color: white;
    font-size: 15px;
    font-weight:500;
    border: 1px solid black;
    border-radius: 3px;
    padding: 3px 7px;
    margin: 2px;
}
.btn-address:hover {
    background-color: #555555;
    color: white;
}
.btn-address-gps {
    background-color: #E94B3C;
    color: white;
    text-align: center;
    padding: 3px 7px;
    margin: 2px;
    border: 1px solid black;
    border-radius: 3px;
    color: white;
    font-size: 15px;
    font-weight:500;
}
.btn-address-gps:hover {
    background-color: #555555;
    color: white;
}
.pac-container {
    z-index: 10511 !important;
}

.omniva-li:hover{
 cursor: pointer;
}
.omniva-terminals-list li {padding: 5px; border-radius: 4px;}
.omniva-terminals-list li:nth-child(even) {background: #f2f2f2;}
/*.omniva-terminals-list li:hover { background: #e6e6e6;}*/

.omniva-search {
        width: 98%;
    padding: 2px 10px;
    /* margin: 8px 0; */
    /*box-sizing: border-box;*/
    border: 1px solid #555;
    border-radius: 3px;
}

.btn-marker {
    background-color: white;
    color: black;
    padding: 4px;
    border: 1px solid black;
    border-radius: 2px;
}
.btn-marker:hover {
    background-color: #555555;
    color: white;
}
{/literal}
</style>

<script>
    var omnivaSearch = "{l s='Įveskite adresą paieškos laukelyje, norint surasti paštomatus'}";
    {literal}
        var modal = document.getElementById('omnivaLtModal');
        var btn = document.getElementById("show-omniva-map");
        window.document.onclick = function(event) {
            if (event.target == modal || event.target.id == 'omnivaLtModal' || event.target.id == 'terminalsModal') {
                document.getElementById('omnivaLtModal').style.display = "none";
            } else if(event.target.id == 'show-omniva-map') {
                document.getElementById('omnivaLtModal').style.display = "block";
                document.querySelector('.found_terminals').innerHTML = omnivaSearch;
            }
        }
    {/literal}
</script>

<div id="omnivaLtModal" class="modal">
  <div class="omniva-modal-content">
    <div class="omniva-modal-header">
      <span class="close" id="terminalsModal">&times;</span>
      <h5 style="display: inline">{l s='Omniva Terminalai'}</h5>
      <hr/>
    </div>
    <div class="omniva-modal-body" style="overflow: hidden;">
        <div id="map-omniva-terminals" 
            style=" width: 59%; height: 100%; border: 1px solid black; background-color: lightgray !important; float:left;">
        </div>
        <div style="width: 40%;padding: 0px 10px; float:left;overflow:hidden;">
            <input id="address-omniva" type="textbox" class="omniva-search" placeholder="{l s='Surasti pagal adresą'}">
            <div style="width: 98%; display: flex; justify-content: flex-end">
                <input type="button" class="btn-address" value="{l s='Surasti'}" onclick="codeAddress()">
                <input type="button" class="btn-address-gps" onclick="findNearest()" value="{l s='Surasti artimiausius'}"/>
            </div>
            <div class="found_terminals" style="margin-top:5px;max-height:90%;overflow:hidden;"></div>
        </div>
    </div>
  </div>
</div>
{/if}