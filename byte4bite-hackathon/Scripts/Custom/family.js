$(function () {

    $.post("/Family/GetFamilies/", function (data) {
        var obj = {
            families: data
        };
        //$("#familiesTemplate").tmpl(data);
        var source = $("#familiestemplate").html();
        var template = Handlebars.compile(source);
        $("#familiescontainer").empty().append(template(obj));
    });
    $("#1").on("click", function () {
        alert('aergaerg');
    });

    $(".familyLineItem").on('click', function () {
        var id = $(this).attr("id");
        alert('test');
        //some type of redirect to family cart page
        $("#familiesCartTemplate").show();
        $("#familiesTemplate").hide();
    });

    $("#seachText").keypress(function (e) {
        if (e == 13) {
            // retemplate familiesCartTemplate based off $("#searchText").val()
        }
    });

    $(".itemQuantity").change(function () {
        var id = $(this).attr("id").split('_')[0];

        $("#" + id + "_PointEquivalent").text($(this).val());

        var total = parseFloat($("#totalPoints").text()) + 1;
        $("#totalPoints").text(total);
    });

    $("#checkoutFamily").on("click", function () {
        $("#familiesCartTemplate").hide();
        $("#familiesTemplate").show();
    });
});