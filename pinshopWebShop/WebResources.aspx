<%@ Page Language="C#" AutoEventWireup="true"  %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Drawing" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    
    <script type="text/javascript">
		window.onload = ShowWebResources;
		
		function ShowWebResources()
		{
			var scripts = document.getElementsByTagName("script");
			ShowWebResourceByAttribute(scripts, "src");
			
			var links = document.getElementsByTagName("link");
			ShowWebResourceByAttribute(links, "href");
		}
		
		function ShowWebResourceByAttribute(elements, attributeName)
		{
			var resourcesDropDown = document.getElementById("resourcesDropDown");
			for (var i = 0; i < elements.length; i++)
			{
				var element = elements[i];
				var data = element.getAttribute(attributeName);
				if (data != null && data.match(/webresource.axd/i))
				{
					var assemblyData = data.match(/d=([^&]+)&/)[1];
					
					var option = document.createElement("option");
					option.innerHTML = assemblyData;
					option.value = assemblyData;
					resourcesDropDown.appendChild(option);
				}
			}
		}
		
		function UpdateResourceText(textBox)
		{
			var data = textBox.value;
			var matches = data.match(/d=([^&]+)&/);
			if (matches != null && matches.length > 0)
			{
				textBox.value = matches[1];
			}
		}
		</script>
		
		<script runat="server">
protected void decryptButton_Click(object sender, EventArgs e)
            {
                string urlEncodedData = Request.Form["resourceTextBox"];
                if (string.IsNullOrEmpty(urlEncodedData))
                    urlEncodedData = Request.Form["resourcesDropDown"];
                if (string.IsNullOrEmpty(urlEncodedData))
                    return;

                decryptedLabel.Text = Decrypt(urlEncodedData);
                
                //byte[] encryptedData = HttpServerUtility.UrlTokenDecode(urlEncodedData);

                //Type machineKeySection = typeof(MachineKeySection);
                //Type[] paramTypes = new Type[] { typeof(bool), typeof(byte[]), typeof(byte[]), typeof(int), typeof(int) };
                //MethodInfo encryptOrDecryptData = machineKeySection.GetMethod("EncryptOrDecryptData", BindingFlags.Static | BindingFlags.NonPublic, null, paramTypes, null);

                //try
                //{
                    //byte[] decryptedData = (byte[])encryptOrDecryptData.Invoke(null, new object[] { false, encryptedData, null, 0, encryptedData.Length });
                    //string decrypted = Encoding.UTF8.GetString(decryptedData);

                    //decryptedLabel.BackColor = Color.Lime;
                    //decryptedLabel.Text = decrypted;
                //}
                //catch (TargetInvocationException ex)
                //{
                    //decryptedLabel.BackColor = Color.Red;
                    //decryptedLabel.Text = "Error decrypting data. Are you running your page on the same server and inside the same application as the web resource URL that was generated?";
                //}
            }

            private string Decrypt(string webResourceParameter)
            {
                var purposeType = Type.GetType("System.Web.Security.Cryptography.Purpose, System.Web, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a");

                if (purposeType == null)
                    return "Error";

                try
                {
                    var purpose = Activator.CreateInstance(purposeType, "AssemblyResourceLoader.WebResourceUrl");

                    const BindingFlags decryptFlags = BindingFlags.NonPublic | BindingFlags.Static;
                    var decryptString = typeof (Page).GetMethod("DecryptString", decryptFlags);

                    var decrypt = decryptString.Invoke(null, new[] {webResourceParameter, purpose}) as string;
                    return decrypt;
                    //decryptedLabel.Text = decrypt;
                }
                catch (Exception ex)
                {
                    return "Error";
                }
            }

		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<label for="resourceTextBox">Paste a web resource URL:</label><br />
		<input type="text" id="resourceTextBox" name="resourceTextBox" onchange="UpdateResourceText(this)" /><br />
		<label for="resourcesDropDown">Select a web resource on this page:</label><br />
		<select id="resourcesDropDown" runat="server"></select><br />
		
		<asp:Button ID="decryptButton" runat="server" Text="Decrypt" OnClick="decryptButton_Click" />
		
		<hr />
		<asp:Label ID="decryptedLabel" runat="server"></asp:Label>
		
    </div>
    </form>
</body>
</html>
