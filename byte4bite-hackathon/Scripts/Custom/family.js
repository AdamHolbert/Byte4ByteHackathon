﻿var families = [];
var items = [];
$(function () {

    $.post("/Family/GetFamilies/", function (data) {
        families = data;

        var obj = {
            families: families
        };
        //$("#familiesTemplate").tmpl(data);
        var source = $("#familiestemplate").html();
        var template = Handlebars.compile(source);
        $("#familiescontainer").empty().append(template(obj));
        $(".familyLineItem").click(function () {
            var id = $(this).attr("id");
            var family;
            for (var i = 0; i < families.length; i++) {
                if (families[i].ID == id) {
                    family = families[i];
                    continue;
                }
            }
            //some type of redirect to family cart page
            $("#familiescartmain").show();
            $("#familiesmain").hide();
            $("#familycartheader").text("Family " + family.FamilyID + " Cart");
            $("#maxPoints").text(family.MaxOrderQuantity);
            getPantryInventory();
        });
    });

    //$(".familyLineItem").on('click', function () {
    //    var id = $(this).attr("id");
    //    alert('test');
    //    //some type of redirect to family cart page
    //    $("#familiesCartTemplate").show();
    //    $("#familiesTemplate").hide();
    //});

    $("#seachText").keypress(function (e) {
        if (e.which == 13) {
            var searchText = $(this).val().toUpperCase();
            if (searchText == "") {
                for (var i = 0; i < items.length; i++) {
                     $("#" + items[i].ItemID).removeClass("hidden");
                }
            }
            else {
                //$(".itemLineItem").css('display','none');
                for (var i = 0; i < items.length; i++) {
                    if (items[i].ItemName.toUpperCase().includes(searchText)) {
                        $("#" + items[i].ItemID).removeClass("hidden");
                    } else {
                        $("#" + items[i].ItemID).addClass("hidden");
                    }
                }
            }
        }
    });

    $("#checkoutFamily").click(function () {
        $("#familiesCartTemplate").hide();
        $("#familiesTemplate").show();
    });
});

function getPantryInventory() {
    $.post("/Inventory/GetProductsForPantry", { pantryID: 1 }, function (data) {
        items = data;
        var obj = {
            items: data
        };
        var source = $("#familiescarttemplate").html();
        var template = Handlebars.compile(source);
        $(".cartcontainer").empty().append(template(obj));

        $(".itemQuantity").change(function () {
            var id = $(this).attr("id").split('_')[0];
            var quantity = parseFloat($(this).val());
            var item;
            for (var i = 0; i < items.length; i++) {
                if (items[i].ItemID == id) {
                    item = items[i];
                    continue;
                }
            }

            var itemTotal = quantity * item.Points;
            $("#" + id + "_PointEquivalent").text(itemTotal);

            var runningTotal = 0;
            $.each($(".itempointtotal"), function (i, ele) {
                runningTotal += parseFloat($(ele).text());
            });
            $("#totalPoints").text(runningTotal);
        });

        
    });
}