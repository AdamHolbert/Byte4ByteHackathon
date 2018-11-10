$(function () {
    alert('im home');

    $("#getdata").click(function () {
        var postObj = {
            ID: $("#datatopost").val()
        };
        $.post("/Home/GetData/", postObj, function (data) {
            alert(data);
        });
    });

    $("#getitemsfordropdown").click(function () {
        $.post("/Home/GetDropDownData", function (data) {
            $("#dropdownlist").find('option').not(':first').remove();
            $.each(data, function (i, item) {
                //remove all existing options but the first
                $("#dropdownlist").append("<option value=" + item.Key + ">" + item.Value + "</option>");
            });
        });
    });

    $("#getdummytemplate").click(function () {
        $.post("/Home/GetDummyTemplateInfo", function (data) {
            var source = $(".dummytemplate").html();
            var template = Handlebars.compile(source);
            $("#dummytemplateplaceholder").empty().append(template(data));
        });
    });
        
});