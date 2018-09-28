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
    <select class="select2" name="omnivalt_parcel_terminal">{$parcel_terminals}</select>
    
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

        <script type="text/javascript">
        var locations = {$terminals_list};
        {literal}
        window.onload = function(e){

            var map = new google.maps.Map(document.getElementById('map-omniva-terminals'), {
            zoom: 7,
            center: new google.maps.LatLng(54.917362, 23.966171),
            mapTypeId: google.maps.MapTypeId.ROADMAP
            });

        var infowindow = new google.maps.InfoWindow();
        var marker, i;

        

        function terminalSelected2(terminal, selection = "Pasirinkite terminala") {
            let terminalSelection = document.querySelector(".selectedTerminal")
            terminalSelection.innerHTML = selection
            
            console.log('arrow function to select terminal');
            omnivaSelect = document.getElementsByName("omnivalt_parcel_terminal");
            /*omnivaOption = document.getElementsByTagName("option");
            omnivaSelect.value = terminal;
*/
            var container = document.querySelector("select[name='omnivalt_parcel_terminal']");
            console.log(container, container.length)
            let tSelector = "optgoup > option[value='"+terminal+"']";
            var matches = document.querySelectorAll(".omnivaOption");
            matches.forEach(node => {
                if(node.getAttribute("value") == terminal)
                    node.selected = 'selected';
                else
                    node.selected = false;
            })
            
            $('select[name="omnivalt_parcel_terminal"]').show();
            $('select[name="omnivalt_parcel_terminal"]').click();
            omnivaSel = document.getElementsByName("omnivalt_parcel_terminal");
            console.log(omnivaSelect)
            /*!omnivaSel.dispatchEvent(new Event('change'));
            */
            console.log(matches, matches.length, tSelector);
            
        }

        /*const treminalDisplay = (terminal) => {*/
        function terminalDisplay(terminal) {
            terminalSelected(terminal[3], `${terminal[0]} ${terminal[5]}`);
            return (
                `<div onclick="terminalSelected(${terminal[3]}, '${terminal[0]} ${terminal[5]}')">\
                <b>${terminal[0]}</b><br /> \
                ${terminal[4]}<br />\
                ${terminal[5]} <br/> \
                ${terminal[6]} <br/> \
                </div>`
            );
        }

        markers = [];
        const image = 'http://localhost/prestashop/modules/omnivaltshipping/sasi.png';
        for (i = 0; i < locations.length; i++) {  
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                map: map,
                icon: image,
            });

            markers[i] = marker;

            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                infowindow.setContent(terminalDisplay(locations[i]));
                infowindow.open(map, marker);
                }
            })(marker, i));
        }

          var markerCluster = new MarkerClusterer(map, markers,
                      {imagePath: 'http://localhost/prestashop/modules/omnivaltshipping/m'});
        }

        function terminalSelected(terminal, selection = "Pasirinkite terminala") {
            
            let terminalSelection = document.querySelector(".selectedTerminal")
            terminalSelection.innerHTML = selection
            
            console.log('arrow function to select terminal');
            omnivaSelect = document.getElementsByName("omnivalt_parcel_terminal");
            /*omnivaOption = document.getElementsByTagName("option");
            omnivaSelect.value = terminal;
*/
            var container = document.querySelector("select[name='omnivalt_parcel_terminal']");
            console.log(container, container.length)
            let tSelector = "optgoup > option[value='"+terminal+"']";
            var matches = document.querySelectorAll(".omnivaOption");
            matches.forEach(node => {
                if(node.getAttribute("value") == terminal)
                    node.selected = 'selected';
                else
                    node.selected = false;
            })
            
            $('select[name="omnivalt_parcel_terminal"]').show();
            $('select[name="omnivalt_parcel_terminal"]').trigger("change");
            $('select[name="omnivalt_parcel_terminal"]').trigger("click").click();
            omnivaSel = document.getElementsByName("omnivalt_parcel_terminal");
            console.log(omnivaSelect)
            /*!omnivaSel.dispatchEvent(new Event('change'));
            */
            console.log(matches, matches.length, tSelector);
        }
        {/literal}
    </script>
<!--
<div id="map-omniva-terminals" style="width: 500px; height: 300px; border: 1px solid black;box-shadow: 3px 3px 1px grey; background-color: lightgray !important;
"></div>
-->



<!-- Map modal -->
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



<button id="myBtn" class="btn btn-basic btn-sm">Terminalai</button>

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class="close">&times;</span>
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

<script>
{literal}
// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.document.onclick = function(event) {
    console.log(event)
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
{/literal}
</script>
<!--/ Map modal -->
</div>