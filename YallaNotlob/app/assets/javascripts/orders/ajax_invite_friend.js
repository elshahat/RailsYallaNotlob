$(function() {
    $('#invite_friend').autocomplete({
        type: "POST",
        serviceUrl: '/users/lookup/',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'Sorry, no matching results',
        onSearchStart: function(params) {
            var invited_friends = [];
            var invited_groups = [];
            $('.invited').each(function(index) {
                invited_friends.push($(this).val());
            });
            $('.group-invited').each(function(index) {
                invited_groups.push($(this).val());
            });
            params.invited = invited_friends;
            params.groups_invited = invited_groups;
        },
        onSelect: function(suggestion) {
            // console.log(suggestion.data.members);
            if (suggestion.data.members) {
                $('#groups-area').append('<input class="group-invited" type="hidden" name="group_invited[]" value="' + suggestion.data.id + '">');
                $.each(suggestion.data.members, function(key, value) {
                    $('#invites-area').append('<input class="invited" type="hidden" name="invited[]" value="' + value.id + '">');
                    $('#friends-invited').append(
                        $('<div/>')
                        .addClass("panel panel-default")
                        .append($('<div/>')
                            .addClass("panel-heading")
                            .text(value.username.toUpperCase())
                            .append($('<span/>')
                                .addClass('btn glyphicon glyphicon-remove col-sm-push-9')
                                .attr("id", value.id)
                            )
                        )
                    );
                    $("#" + value.id).click(function(e) {
                        $(e.target).parent().parent().remove();
                        $('.invited[value = "' + value.id + '"]').remove();
                    });
                });
            } else {

                $('#invites-area').append('<input class="invited" type="hidden" name="invited[]" value="' + suggestion.data.id + '">');
                $('#friends-invited').append(
                    $('<div/>')
                    .addClass("panel panel-default")
                    .append($('<div/>')
                        .addClass("panel-heading")
                        .text(suggestion.value.toUpperCase())
                        .append($('<span/>')
                            .addClass('btn glyphicon glyphicon-remove col-sm-push-9')
                            .attr("id", suggestion.data.id)
                        )
                    )
                );
                $("#" + suggestion.data.id).click(function(e) {
                    $(e.target).parent().parent().remove();
                    $('.invited[value = "' + suggestion.data.id + '"]').remove();
                });
            }
            $('#invite_friend').val("");
        }
    });
});
