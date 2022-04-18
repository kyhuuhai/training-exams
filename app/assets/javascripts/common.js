$( document ).on("turbolinks:load" ,function ()
{
  document.querySelector( ".btn-finish-exam" ).onclick = function ()
  {
    var radioValue = $( "input[type='radio']:checked" );
    var values = radioValue.map( function ()
    {
      return $( this ).val();
    } );
    a = [];
    for ( i = 0; i < values.length; i++ )
    {
      id = values.prevObject[ i ].name;
      answer = values.prevObject[ i ].id;
      a.push( { id, answer } );
    }
    console.log( a.length );
    console.log( $( this ).data().id );
    $.ajax( {
      type: 'POST',
      url: "/user/exams/" + $( this ).data().id + "/result_exams",
      beforeSend: function ( xhr ) { xhr.setRequestHeader( 'X-CSRF-Token', $( 'meta[name="csrf-token"]' ).attr( 'content' ) ) },
      data: {
        id: $( this ).data().id,
        data: a,
        length: a.length,
      },
      dataType: 'JSON'
    }).done( function ( data )
    {
      alert( "Xem diem cua ban" );
    })
  };
});
