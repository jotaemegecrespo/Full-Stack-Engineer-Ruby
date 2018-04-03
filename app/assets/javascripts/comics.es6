$(document).ready( () => {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  $('.search input').on('keypress', (e) => {
    if(e.which == 13) {
      let searchTerm = e.target.value;
      let parameter =  `?character=${searchTerm}`;
      window.location = `/comics${searchTerm ? parameter : ''}`;
    }
  });

  $('.comic a.fav').click((e) => {
    e.preventDefault();
    console.log(e);
    let favLink = e.target;
    let url = favLink.href;
    $.ajax({
      url: url,
      method: 'POST',
      success: () => { $(favLink).toggleClass('favourite') },
    })
  });

});
