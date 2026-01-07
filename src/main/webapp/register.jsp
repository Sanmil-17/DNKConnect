<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% response.setHeader("Cache-Control", "no-cache"); response.setHeader("Cache-Control", "no-store"); response.setHeader("Pragma", "no-cache"); response.setDateHeader("Expires", 0); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ecom : Register</title>
<%@include file="component/css.jsp"%>
<style type="text/css">
    .error {
        color: red;
    }
        select {
        max-height: 200px; /* Limit dropdown height */
        overflow-y: auto; /* Add vertical scrolling */
    }
</style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<div class="container mt-5 p-5">
    <div class="row">
        <div class="col-md-5 p-5">
            <img alt="" src="data/img/ecom.png" width="100%" height="400px">
        </div>
        <div class="col-md-6 offset-md-1 mt-1">
            <div class="card card-sh">
                <div class="card-header">
                    <p class="fs-5 text-center">Register</p>
                    <c:if test="${not empty errorMsg}">
                        <p class="fs-4 text-center text-danger">${errorMsg}</p>
                        <c:remove var="errorMsg" scope="session" />
                    </c:if>
                    <c:if test="${not empty succMsg}">
                        <p class="fs-4 text-center text-success">${succMsg}</p>
                        <c:remove var="succMsg" scope="session" />
                    </c:if>
                </div>
                <div class="card-body">
                    <form action="registerUser" method="post" novalidate enctype="multipart/form-data" id="userRegister">
                        <div class="row">
                            <div class="col">
                                <label class="form-label">Full Name</label>
                                <input required name="fullname" type="text" class="form-control form-control-sm"
                                       pattern="[A-Za-z ]{2,50}" title="Only letters and spaces are allowed. Between 2-50 characters.">
                            </div>
                            <div class="col">
                                <label class="form-label">Mobile Number</label> 
								<input 
   								    required 
   									name="mobno" 
   									type="tel" 
    								class="form-control form-control-sm" 
    								maxlength="10" 
    								pattern="[6-9][0-9]{9}" 
   									title="Enter a valid 10-digit mobile number starting with 6, 7, 8, or 9"> 
                            </div>
                        </div>

                        <div class="mt-2">
                            <label class="form-label">Email</label>
                            <input required name="email" type="email" class="form-control form-control-sm">
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <label class="form-label">Address</label>
                                <input required name="address" type="text" class="form-control form-control-sm">
                            </div>
                            <div class="col">
                                <label class="form-label">City</label>
                                <select required name="city" class="form-control form-control-sm" id="cityDropdown">
                                    <option value="">Select a City</option>
                                </select>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col">
                                <label class="form-label">State</label>
                                <select required name="state" class="form-control form-control-sm" id="stateDropdown">
                                   <option value="">Select a State</option>
								    <option value="Maharashtra">Maharashtra</option>
								    <option value="Karnataka">Karnataka</option>
								    <option value="Tamil Nadu">Tamil Nadu</option>
								    <option value="Rajasthan">Rajasthan</option>
								    <option value="Gujarat">Gujarat</option>
								    <option value="Punjab">Punjab</option>
								    <option value="Uttar Pradesh">Uttar Pradesh</option>
								    <option value="West Bengal">West Bengal</option>
								    <option value="Kerala">Kerala</option>
								    <option value="Madhya Pradesh">Madhya Pradesh</option>
								    <option value="Bihar">Bihar</option>
								    <option value="Haryana">Haryana</option>
								    <option value="Andhra Pradesh">Andhra Pradesh</option>
								    <option value="Telangana">Telangana</option>
								    <option value="Delhi">Delhi</option>
                                </select>
                            </div>
  
								<div class="col">
								    <label class="form-label">Pincode</label>
								    <input 
								        required
								        name="pincode"
								        type="text"
								        class="form-control form-control-sm"
								        maxlength="6" 
								        title="Pincode must be 6 digits, cannot start with 0, and may have an optional space after the third digit">
								</div>


                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col">
                                <label class="form-label">Password</label>
                                <input required name="password" type="password" id="pass" class="form-control form-control-sm">
                            </div>
                            <div class="col">
                                <label class="form-label">Confirm Password</label>
                                <input required name="confirmpassword" type="password" class="form-control form-control-sm">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Profile Image</label>
                                <input required name="img" type="file" class="form-control">
                            </div>
                        </div>
                        <button type="submit" class="btn bg-primary text-white col-md-12 mt-3">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>                                                                                          

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.js"></script>
<script type="text/javascript" src="data/js/user_script.js"></script>

<script>
    $(document).ready(function () {
        $('#userRegister').on('submit', function (e) {
            const pincode = $('input[name="pincode"]').val();
            const pincodeRegex = /^[1-9][0-9]{2}(\s?[0-9]{3})$/;

            if (!pincodeRegex.test(pincode)) {
                alert('Please enter a valid 6-digit pincode. It should not start with 0 and may have an optional space after the third digit.');
                e.preventDefault(); // Prevent form submission
            }
        });
    });
</script>

<script>
	
    $(document).ready(function () {
    	const cityMap = {
    		    "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik", "Aurangabad"],
    		    "Karnataka": ["Bangalore", "Mysore", "Mangalore", "Hubli", "Belgaum"],
    		    "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai", "Salem", "Tiruchirappalli"],
    		    "Rajasthan": ["Jaipur", "Jodhpur", "Udaipur", "Ajmer", "Bikaner"],
    		    "Gujarat": ["Ahmedabad", "Surat", "Vadodara", "Rajkot", "Bhavnagar"],
    		    "Punjab": ["Amritsar", "Ludhiana", "Patiala", "Jalandhar", "Bathinda"],
    		    "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi", "Agra", "Meerut"],
    		    "West Bengal": ["Kolkata", "Darjeeling", "Howrah", "Durgapur", "Siliguri"],
    		    "Kerala": ["Thiruvananthapuram", "Kochi", "Kozhikode", "Thrissur", "Alappuzha"],
    		    "Madhya Pradesh": ["Bhopal", "Indore", "Gwalior", "Jabalpur", "Ujjain"],
    		    "Bihar": ["Patna", "Gaya", "Muzaffarpur", "Bhagalpur", "Darbhanga"],
    		    "Haryana": ["Gurgaon", "Faridabad", "Panipat", "Ambala", "Karnal"],
    		    "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur", "Nellore", "Tirupati"],
    		    "Telangana": ["Hyderabad", "Warangal", "Nizamabad", "Khammam", "Karimnagar"],
    		    "Delhi": ["New Delhi", "Dwarka", "Rohini", "Saket", "Janakpuri"]
    		};

        $('#stateDropdown').change(function () {
            const state = $(this).val();
            const cities = cityMap[state] || [];
            const cityDropdown = $('#cityDropdown');

            cityDropdown.empty();
            cityDropdown.append('<option value="">Select a City</option>');
            cities.forEach(function (city) {
                cityDropdown.append('<option value="' + city + '">' + city + '</option>');
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        // Check if there's a success message
        const succMsg = '${succMsg}';
        if (succMsg) {
            alert(succMsg);
            // Redirect to the login page after showing the alert
            window.location.href = 'login.jsp';
        }
    });
</script>


<c:if test="${not empty succMsg}">
    <script>
        // Display success message in a dialog box
        alert('${succMsg}');
        // Redirect to login page after showing the dialog box
        window.location.href = 'login.jsp';
    </script>
</c:if>
</body>
</html>
