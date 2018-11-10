$(function () {

    $("#inventoryTemplate").click(function () {
        $.post("/Inventory/Index", function (data) {
            var source = $(".dummytemplate").html();
            var template = Handlebars.compile(source);
            $("#inventoryHolder").empty().append(template(data));
        });
    });

});