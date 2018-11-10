var newCount = 1;
$(function () {
    $.post("/Inventory/GetProductsForPantry", { pantryID: 1 }, function (data) {
        var source = $(".inventoryTemplate").html();
        var template = Handlebars.compile(source);
        var obj = {
            Items: data
        };
        $("#inventoryHolder").empty().append(template(obj));
    });

    $("#editButton").on("click", function () {
        $.post("/Inventory/GetProductsForPantry", { pantryID: 1 }, function (data) {
            var source = $(".inventoryEdit").html();
            var template = Handlebars.compile(source);
            var obj = {
                Items: data
            };
            $("#inventoryHolder").empty().append(template(obj));

            $("#addLineItem").click(function () {
               
                    var source = $(".addLine").html();
                    var template = Handlebars.compile(source);
                    var obj = {
                        ID: newCount++
                    };
                $("#editTable tbody").append(template(obj));
            });

            $("#doneEdit").click(function () {
                var newItems = [];
                $.each($(".existingItem"), function (i, ele) {
                    var id = $(ele).attr("ID").split("_")[1];
                    var newItemName = $("#existingItemName_" + id).val();
                    var newItemCount = $("#existingItemCount_" + id).val();
                    var newIRequest = $("existingItemRequest_" + id).val();
                    var newItemPoints = $("existingItemPoints_" + id).val();
                    var newObj = {
                        newItemName,
                        newItemCount,
                        newIRequest,
                        newItemPoints
                    };
                    newItems.push(newObj);
                });
                $.each($(".newItem"), function (i, ele) {
                    var id = $(ele).attr("ID").split("_")[1];
                    var newItemName = $("#newItemName_" + id).val();
                    var newItemCount = $("#newItemCount_" + id).val();
                    var newIRequest = $("newItemRequest_" + id).val();
                    var newItemPoints = $("newItemPoints_" + id).val();
                    var newObj = {
                        newItemName,
                        newItemCount,
                        newIRequest,
                        newItemPoints
                    };
                    newItems.push(newObj);
                });

                //implement validation logic before posting
                //alter ui to inform users of the problems
                //when successful post the items to the server, save to the database and retemplate the page with display only
                $.post("/Inventory/UpdatePantryProducts", { pantryID: 1 }, function (data) {
                    
                });
            });
        });

    });

    
});