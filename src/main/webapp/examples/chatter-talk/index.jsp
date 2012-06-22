<%@ page import="platform.connect.api.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%
    // Pull the signed request out of the request body and unsign it.
    Map<String, String[]> parameters = request.getParameterMap();
    String[] signedRequest = parameters.get("signed_request");
    if (signedRequest == null) {%>This App must be invoked via a signed request!<%
        return;
    }
    String yourConsumerSecret="7346776367677698305";
    String signedRequestJson = SignedRequest.unsignAsJson(signedRequest[0], yourConsumerSecret);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Chatter Talk Example</title>
    <link rel="stylesheet" type="text/css" href="/examples/chatter-talk/talk.css" />
    <script type="text/javascript" src="/sdk/js/connect.js"></script>
    <script type="text/javascript" src="/sdk/js/xd.js"></script>
    <script type="text/javascript" src="/sdk/js/client.js"></script>
    <script type="text/javascript" src="/scripts/json2.js"></script>
    <script type="text/javascript" src="/examples/chatter-talk/chatter-talk.js"></script>

</head>
<body>
<div class="slide device-access" id="speech-input">
    <section>
        <div id="stylized" class="flex hbox boxcenter">

            <div class="noflex vbox boxcenter" style="height:130px;text-align:center">
            <img id="profile-image" alt="image" src="/images/image.gif" width="100" height="100" />
            <p>
                <strong>Max Power</strong><br/>
            </p>
            </div>

            <div class="noflex vbox boxcenter" style="height:100px;text-align:center">
                <input id="speech-input-field" type="text" x-webkit-speech />
                <p style="display:none">Speech input is not enabled in your browser.<br>
                    Try running Google Chrome with the <code>--enable-speech-input</code> flag.</p>
            </div>
            <div class="noflex vbox boxcenter" style="height:50px;text-align:center">
                <button id="chatter-submit" type="submit"></button>&nbsp<span id="status" style="color:green"></span>
            </div>
        </div>
        <script>
            if (!('webkitSpeech' in document.createElement('input'))) {
                document.querySelector('#speech-input p').style.display = 'block';
            }
            var sr = JSON.parse('<%=signedRequestJson%>');
            chatterTalk.init(sr, "chatter-submit", "speech-input-field", function(data) {
                if (data.status === 201) {
                    connect.byId.innerHTML = "Success"
                }
            });
        </script>
    </section>
</div>

</body>
</html>