<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="Foodie.User.Review" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        /*For disaapearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Review section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label runat="server" ID="lblMsg"></asp:Label>
                </div>
                <h2>Give Your Review Please !!</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="rfvReview" runat="server" ErrorMessage="Review is required" ControlToValidate="txtReview"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtReview" runat="server" CssClass="form-control" placeholder="Enter Your review" ToolTip="Review"
                                TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Name must be in characters only"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[a-zA-Z\s]+$" ControlToValidate="txtName">
                            </asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name"></asp:TextBox>

                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revAddress" runat="server" ErrorMessage="Address must be in characters only"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="[a-zA-Z\s]+$" ControlToValidate="txtAddress">
                            </asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" ToolTip="Address"
                                TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvImage" runat="server" ErrorMessage="Image is required"  ControlToValidate="fuReviewImage"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:FileUpload ID="fuReviewImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" />
                        </div>

                        <div class="form-check pl-4 pb-4">
                            <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp; IsActive"
                                CssClass="form-check-input" />
                        </div>

                        <div class="btn_box pt-4">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-warning rounded-pill pl-4 pr-4 text-white" 
                                OnClick="btnSubmit_Click" />
                        </div>

                        <div>
                            <asp:Image ID="imgReview" runat="server" CssClass="img-thumbnail" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end review section -->

</asp:Content>
