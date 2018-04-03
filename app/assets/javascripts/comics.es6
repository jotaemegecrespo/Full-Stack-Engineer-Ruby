$(document).ready( () => {
  $('.search input').on('keypress', (e) => {
    if(e.which == 13) {
      let searchTerm = e.target.value;
      let parameter =  `?character=${searchTerm}`;
      window.location = `/comics${searchTerm ? parameter : ''}`;
    }
  });
});
