$( document ).ready( function ()
{
  document.querySelector( ".btn-finish-exam" ).onclick = function ()
  {
    var minutes = document.querySelector( ".timer__part--minutes" ).innerHTML;
    var seconds = document.querySelector( ".timer__part--seconds" ).innerHTML;

    console.log( minutes + ":" + seconds );
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
      url: "/user/exams/" + $( this ).data().id + "/history_do_exams",
      beforeSend: function ( xhr ) { xhr.setRequestHeader( 'X-CSRF-Token', $( 'meta[name="csrf-token"]' ).attr( 'content' ) ) },
      data: {
        id: $( this ).data().id,
        data: a,
        length: a.length,
        minutes: minutes,
        seconds: seconds,
      },
      dataType: 'JSON'
    } ).done( function ( data )
    {
      console.log( data );
      window.location.href = data.url + "&minutes=" + parseInt( data.minutes ) + "&seconds=" + parseInt( data.seconds );

      alert( "Xem diem cua ban" );
    } ).fail( function ( data )
    {
      alert( data.message );
    } );
  };
} );
