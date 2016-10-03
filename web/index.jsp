<%-- 
    Document   : index
    Created on : Oct 3, 2016, 7:45:34 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chat Demo</title>
        <link rel="stylesheet" href='css/bootstrap.css'>
    </head>
    <body>
         
        <div class="container">
            <h1>Chat Demo for P'non</h1>
            <h2>You're User 1 Name : James</h2>
            <h2>Your Chatmate is User 2 Name : Kevin</h2>
            <a href="index2.jsp"><p>see in Kevin chat</p></a>
            <hr>
            <input type="text" id="chat-text" class="form-control" placeholder="Type Here" > <a id="btn" href="#" class="btn btn-primary">Send</a>
            <input type="hidden" id="userId1" value="1">
             <input type="hidden" id="userId2" value="2">
            <br>
            <div class="row">
                <ul class="list-group">
                   
                </ul>
            </div>
        </div>


        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/firebase.js"></script>
        <script>
             $(function () {
                 var input = $('#chat-text');
                 var btn = $('#btn');
                 var ul = $('ul');
                 var id1 = $('#userId1');
                 var id2 = $('#userId2');
                 var firebaseUrl = 'https://chat-66f1e.firebaseio.com/';
                 var uid = parseInt(id1.val());
                 var uid2 = parseInt(id2.val());
                 if (uid > uid2){
                     var uid3 = uid;
                     uid = uid2;
                     uid2 = uid3;
                 }
                 
                var Connection = new Firebase(firebaseUrl).child(uid+'chatwith'+uid2);
                queryChat();
                
         
                
                
                btn.click(function(){
                      var text = input.val();
                      input.val(''); 
                     var msg = {
                        sender : 'James' ,
                        message : text ,
                        time : 'send at '+new Date()
                     };
                     Connection.push(msg);

                });
                function queryChat(){
                    Connection.on('value' , function(snapshot){
                        var msg = snapshot.val();
                        ul.empty();
                        $.each(msg , function(index , c){
                            addToChatBox(c);
                        });
                    });
                    
                }
                
                   function addToChatBox(text) {
                    var li = '<div class="panel panel-default"><div class="panel-heading">'+text.sender+ '</div>'+
                        '<div class="panel-body">'+text.message+'</div>'+
                         '<div class="panel-footer">'+text.time+'</div>'+
                    '</div><br>';
                    ul.append(li);
                }
                
              });
             
            
            
        </script>

    </body>
</html>
