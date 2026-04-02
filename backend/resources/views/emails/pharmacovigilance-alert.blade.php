<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacovigilance Alert</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .alert-banner {
            background-color: #dc3545;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 5px 5px 0 0;
        }
        .content {
            background-color: #f8f9fa;
            padding: 30px;
            border: 1px solid #dee2e6;
            border-top: none;
            border-radius: 0 0 5px 5px;
        }
        .medication-info {
            background-color: #fff;
            padding: 15px;
            border-left: 4px solid #dc3545;
            margin: 20px 0;
        }
        .action-box {
            background-color: #fff3cd;
            border: 2px solid #ffc107;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
        .footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
            font-size: 12px;
            color: #6c757d;
            text-align: center;
        }
        h1 {
            margin: 0;
            font-size: 24px;
        }
        h2 {
            color: #dc3545;
            margin-top: 0;
        }
        .highlight {
            font-weight: bold;
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="alert-banner">
        <h1>PHARMACOVIGILANCE ALERT</h1>
        <p style="margin: 0;">Important Safety Information</p>
    </div>
    
    <div class="content">
        <p>Dear {{ $customer->name }},</p>
        
        <p>This is an important safety notification regarding a medication you recently purchased from our pharmacy.</p>
        
        <div class="medication-info">
            <h2>Affected Medication</h2>
            <p><strong>Medication Name:</strong> {{ $medication->name }}</p>
            <p><strong>Lot Number:</strong> <span class="highlight">{{ $medication->lot_number }}</span></p>
            <p><strong>Purchase Date:</strong> {{ $order->purchase_date->format('F d, Y') }}</p>
            <p><strong>Order ID:</strong> #{{ $order->id }}</p>
        </div>
        
        <div class="action-box">
            <h2 style="margin-top: 0;">RECOMMENDED ACTION</h2>
            <p>The medication listed above with lot number <strong>{{ $medication->lot_number }}</strong> has been identified in a pharmacovigilance review and may require immediate attention.</p>
            
            <p><strong>Please take the following steps:</strong></p>
            <ul>
                <li>Stop using this medication immediately</li>
                <li>Contact your healthcare provider as soon as possible</li>
                <li>Do not dispose of the medication yet - your healthcare provider may need to examine it</li>
                <li>Contact our pharmacy at your earliest convenience for further instructions</li>
            </ul>
        </div>
        
        <p><strong>Your Safety is Our Priority</strong></p>
        <p>We are committed to ensuring your health and safety. If you have any questions or concerns, please do not hesitate to contact us.</p>
        
        <p><strong>Pharmacy Contact Information:</strong><br>
        Email: <a href="mailto:noreply@pharmacovigilance.com">noreply@pharmacovigilance.com</a><br>
        Phone: {{ $customer->phone ?? 'Please use your regular pharmacy contact' }}</p>
        
        <div class="footer">
            <p>This is an automated alert from the Pharmacovigilance Alert System.</p>
            <p>If you believe you received this email in error, please contact our pharmacy immediately.</p>
            <p>&copy; {{ date('Y') }} Pharmacovigilance Alert System. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
