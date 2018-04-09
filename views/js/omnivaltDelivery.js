var omnivaltDelivery = {
    init : function() {
        var self = this;
        $('.delivery_option_radio').each(function() {
            var $this = $(this),
                value = $this.val(),
                carrierIds = value.split(',');
             
            if (value != omnivalt_parcel_terminal_carrier_id + ',') {
                return;
            }
            
            var $omnivaltItem = $this.closest('.delivery_option');
            var omnivaltLocation = $omnivaltItem.find('table.resume').find('tr').find('td.delivery_option_logo').next('td');
            $(".delivery_option #omnivalt_parcel_terminal_carrier_details").remove();
            $("#HOOK_BEFORECARRIER #omnivalt_parcel_terminal_carrier_details").appendTo(omnivaltLocation);
            //$("#HOOK_BEFORECARRIER #omnivalt_parcel_terminal_carrier_details").remove();
        });
        $("body").on('click','input.delivery_option_radio',function(){
            if ($("input.delivery_option_radio:checked").val() == omnivalt_parcel_terminal_carrier_id + ',') {
                $("#omnivalt_parcel_terminal_carrier_details").show();
            } else {
                $("#omnivalt_parcel_terminal_carrier_details").hide();
            }
        });
        if ($("input.delivery_option_radio:checked").val() == omnivalt_parcel_terminal_carrier_id + ',') {
            $("#omnivalt_parcel_terminal_carrier_details").show();
        } else {
            $("#omnivalt_parcel_terminal_carrier_details").hide();
        }
        
        $(document).on('submit', 'form[name=carrier_area]', function(){
            return self.validate();
        });
        $(document).on('click', '.payment_module a', function(e){
            return self.validate();
        });
        $(document).on('click', '#imitateConfirm', function(e){
            return self.validate();
        });
        $('.confirm_button_div .confirm_button').unbind().attr('onclick', '').on('click', function(e){
            return self.validate();
        });
        $('select[name="omnivalt_parcel_terminal"]').off('change').on('change', function(e) {
            var terminal = $(this).val();
            $.ajax({
                type: 'POST',
                headers: { "cache-control": "no-cache" },
                url: omnivaltdelivery_controller,
                async: true,
                cache: false,
                dataType: 'json',
                data: 'action=saveParcelTerminalDetails'
                    + '&terminal=' + terminal,
                success: function(jsonData)
                {
                    //console.log(jsonData);
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    if (textStatus !== 'abort'){
                        if (!!$.prototype.fancybox)
                        $.fancybox.open([
                            {
                                type: 'inline',
                                autoScale: true,
                                minHeight: 30,
                                content: '<p class="fancybox-error">' + omnivalt_parcel_terminal_error + '</p>'
                            }],
                            {
                                padding: 0
                            }
                        );
                        else
                            alert(omnivalt_parcel_terminal_error);
                    }
                }
            });
        });
    },
    validate : function() {
        if ($('.delivery_option_radio:checked').val() == omnivalt_parcel_terminal_carrier_id + ',' && $('select[name="omnivalt_parcel_terminal"]').val() == "")
        {
            if (!!$.prototype.fancybox) {
                $.fancybox.open([
                {
                    type: 'inline',
                    autoScale: true,
                    minHeight: 30,
                    content: '<p class="fancybox-error">' + omnivalt_parcel_terminal_error + '</p>'
                }],
                {
                    padding: 0
                });
            }
            else {
                alert(omnivalt_parcel_terminal_error);
            }
        }
        else {
            //paymentModuleConfirm(); //if opc
            return true;
        }
        return false;
    },
}
	
//when document is loaded...
