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
    
    public partial class PartnerRate
    {
        public int Id { get; set; }
        public int PartnerId { get; set; }
        public string FromRate { get; set; }
        public string ToRate { get; set; }
        public double Guaranteed { get; set; }
        public double Indicative { get; set; }
        public System.DateTime DateCreated { get; set; }
        public System.DateTime LastModified { get; set; }
        public string Status { get; set; }
        public string RateType { get; set; }
    
        public virtual PartnerDetail PartnerDetail { get; set; }
    }
}
