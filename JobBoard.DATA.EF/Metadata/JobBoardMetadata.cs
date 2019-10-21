using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace JobBoard.DATA.EF
{
    public class UserDetailsMetadata
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ResumeFileName { get; set; }
    }
    [MetadataType(typeof(UserDetailsMetadata))]
    public partial class UserDetail
    {
        public string FullName
        {
            get { return FirstName + " " + LastName; }
        }
    }

    public class ApplicationMetadata
    {
        public int ApplicationID { get; set; }
        public int OpenPositionID { get; set; }
        public string UserID { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public System.DateTime ApplicationDate { get; set; }
        public string ManagerNotes { get; set; }

        public string ResumeFileName { get; set; }
    }
    [MetadataType(typeof(ApplicationMetadata))]
    public partial class Application
    {

    }

    public class PositionMetadata
    {
      
        public string Title { get; set; }
        
       [AllowHtml]
        [Display(Name = "Job Description")]
        public string JobDescription { get; set; }
    }
    [MetadataType(typeof(PositionMetadata))]
    public partial class Position
    {
        
        
    }
}
