//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Navigettr.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class UserQRCodeTracker
    {
        public int PartnerId { get; set; }
        public double TransactionAmount { get; set; }
        public string FromCurrency { get; set; }
        public string ToCurrency { get; set; }
        public System.DateTime DateScanned { get; set; }
        public Nullable<int> UserId { get; set; }
        public int Id { get; set; }
        public int LocationId { get; set; }
        public Nullable<double> Rate { get; set; }
        public string FeedbackRating { get; set; }
        public string FeedbackComment { get; set; }
        public string ServiceType { get; set; }
        public Nullable<double> Fees { get; set; }
        public string FeesCurrency { get; set; }
    }
}
