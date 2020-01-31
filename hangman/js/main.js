$(document)
  .ready( () => {
    $('td').on('click', e => {
      const jQeCT = $(e.currentTarget);
      if (!jQeCT.hasClass('selected')) {
        jQeCT.addClass('selected');
      }
    });
  });
