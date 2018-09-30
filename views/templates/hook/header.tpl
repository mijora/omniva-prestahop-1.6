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


<!-- Modal content -->
<style>
{literal}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    -webkit-animation-name: fadeIn; /* Fade in the background */
    -webkit-animation-duration: 0.4s;
    animation-name: fadeIn;
    animation-duration: 0.4s;
    z-index:99999;
}

/* Modal Content */
.modal-content {
z-index:99999;
    position:fixed;
    top: 20%;
    left: 15%;
    background-color: #fefefe;
    border-radius: 5px;
    width: 70%;
    height:70%;
    -webkit-animation-name: slideIn;
    -webkit-animation-duration: 0.4s;
    animation-name: slideIn;
    animation-duration: 0.4s
}

/* The Close Button */
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

.modal-header {
    padding: 2px 16px;
    /*background-color: #5cb85c;*/
    color: black;
    height: 20%

}


.modal-body {padding: 2px 16px;height:70%;}


/* Add Animation */
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
{/literal}
</style>

<script>
{literal}
    var modal = document.getElementById('myModal');
    var btn = document.getElementById("myBtn");
/*
    var span = document.getElementsByClassName("close")[0];

    span.onclick = function() {
        modal.style.display = "none";
    }
*/
    window.document.onclick = function(event) {
        if (event.target == modal || event.target.id == 'myModal' || event.target.id == 'terminalsModal') {
            document.getElementById('myModal').style.display = "none";
        } else if(event.target.id == 'myBtn') {
            document.getElementById('myModal').style.display = "block";
        }
    }
{/literal}
</script>

<div id="myModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close" id="terminalsModal">&times;</span>
      <h2>Omniva Terminalai</h2>
      <hr/>
    </div>
    <div class="modal-body">
        <div class="selectedTerminal" style="text-align: center; color: #555;
            padding: 5px 0 10px;
            display: inherit;
            background-color: #fafafa;outline: 0;
            border: 1px solid black;border-radius:3px; width: 90%; margin:auto; margin-bottom:15px;">
            Pažymėkite terminala žemelapyje
        </div>
        <div id="map-omniva-terminals" 
            style="margin: auto; width: 90%; height: 90%; border: 1px solid black;box-shadow: 3px 3px 1px grey; background-color: lightgray !important;">
        </div>
    </div>
  </div>
</div>


<!--/ Map modal -->