$( document ).ready( function ()
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
      url: "/user/exams/" + $( this ).data().id + "/history_do_exams",
      // user_exam_histories
      // / user / exams /: exam_id / result_exams
      beforeSend: function ( xhr ) { xhr.setRequestHeader( 'X-CSRF-Token', $( 'meta[name="csrf-token"]' ).attr( 'content' ) ) },
      data: {
        id: $( this ).data().id,
        data: a,
        length: a.length,
      },
      dataType: 'JSON'
    } ).done( function ( data )
    {
      console.log( data );
      console.log( data.result );
      console.log( data.id );
      console.log( data.url );
      window.location.href = data.url;

      // console.log( data.to_json );
      // debugger
      alert( "Xem diem cua ban" );
    } ).fail( function ( data )
    {
      alert( data.message );
    } );
  };
} );
