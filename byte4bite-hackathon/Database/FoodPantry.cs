//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace byte4bite_hackathon.Database
{
    using System;
    using System.Collections.Generic;
    
    public partial class FoodPantry
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public FoodPantry()
        {
            this.FoodPantryStocks = new HashSet<FoodPantryStock>();
            this.PantryCoordinators = new HashSet<PantryCoordinator>();
            this.RequestedItems = new HashSet<RequestedItem>();
        }
    
        public int ID { get; set; }
        public string Location { get; set; }
        public string Name { get; set; }
        public string URL { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<FoodPantryStock> FoodPantryStocks { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PantryCoordinator> PantryCoordinators { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RequestedItem> RequestedItems { get; set; }
    }
}