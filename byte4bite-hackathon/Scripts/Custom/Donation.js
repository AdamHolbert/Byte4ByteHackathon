$(function () {

    $("#donateSubmit").click(function () {
        var postObj = {
            amount: $("#donationInputAmount").val()
        };
        $.post("/Donation/AddDonation/", postObj, function (data) {
            $("#donationMessage").text("Your donation of $" + data.amount + ".00 will feed " + data.studentNum + " hungry students.");
        });
    });

});
