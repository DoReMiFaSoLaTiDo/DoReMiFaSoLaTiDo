function check_this(my_photo, my_name, my_id) {
  var default_img = '/art/01-13264.jpg';
  var update_url = "/artists/" + my_id;
  if (my_photo == default_img)
  {
    $.ajax({
      url: 'https://randomuser.me/api/',
      dataType: 'json'
    })
      .done(function(data){
        $.ajax({
            url: update_url,
            type: 'PUT',
            dataType: 'json',
            data: { 'artist': { 'name': my_name, 'image': data['results'][0]['picture']['large'] } },
            success: function()
                {
                    console.log("database updated successfully");
                }
          });
        });
      }
      return false;
    }
