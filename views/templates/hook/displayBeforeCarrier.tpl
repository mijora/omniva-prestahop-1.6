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
        var base_url = window.location.origin;
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
        const image = base_url+'/modules/omnivaltshipping/sasi.png';
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
                      {imagePath: base_url+'/modules/omnivaltshipping/m'});
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




<button id="myBtn" class="btn btn-basic btn-sm">Terminalai</button>




</div>
