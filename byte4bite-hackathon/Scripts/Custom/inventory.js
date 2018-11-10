$(function () {
    $.post("/Inventory/GetProductsForPantry", { pantryID: 1 }, function (data) {
        var source = $(".inventoryTemplate").html();
        var template = Handlebars.compile(source);
        var obj = {
            Items: data
        };
        $("#inventoryHolder").empty().append(template(obj));
    });
});