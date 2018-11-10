$(function () {

    $.post("/Family/GetFamilies/", function (data) {
        var obj = {
            families: data
        };
        //$("#familiesTemplate").tmpl(data);
        var source = $("#familyrowtemplate").html();
        var template = Handlebars.compile(source);
        $("#familycontainer").empty().append(template(obj));
    });

    //$(".familyLineItem").live('click', function() {
      //  var id = $(this).attr("id");
        // some type of redirect to family cart page
    //});
});