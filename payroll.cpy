
        01 :prefix:payrollRecord.
		    05 :prefix:RegNum     PIC 99.
			
			05 :prefix:RegNam     PIC X(15).
			
            05 :prefix:DepNum       PIC X(5).
			
            05 :prefix:DepName      PIC X(30).
			
            05 :prefix:EmpNum       PIC X(5).
			
            05 :prefix:LastName     PIC X(20).
			
            05 :prefix:FirstName    PIC X(15).
			
            05 :prefix:Gender       PIC X(1).
                88 Female Value "F".
                88 Male Value "M".
                88 Refused Value "R".
                88 Unknown Value "U".
				
            05 :prefix:Adress       PIC X(20).
			
            05 :prefix:CityState    PIC X(20).
			
            05 :prefix:JobTitle     PIC X(20).
			
            05 :prefix:DoB          PIC 9(8).
			
            05 :prefix:DoH.
                10 :prefix:DoHYear  PIC 9999.
                10 :prefix:DoHMonth PIC 99.
                10 :prefix:DoHDay   PIC 99.
				
            05 :prefix:Marital      PIC X.
			    88 Divorced Value "D".
                88 Married Value "M".
                88 Separated Value "P".
                88 Single Value "S".
                88 Widowed Value "W".
				
            05 :prefix:Dependents   PIC 99.
			
            05 :prefix:District     PIC XXX.
			
            05 :prefix:Medical      PIC X.
			
                88 mYes Value "Y".
                88 mNo Value "N".
				
            05 :prefix:Dental       PIC X.
			    88 dYes Value "Y".
                88 dNo Value "N".
				
            05 :prefix:Vision       PIC X.
			    88 vYes Value "Y".
                88 vNo Value "N".
				
            05 :prefix:401k         PIC V999.
			
            05 :prefix:PayCode      PIC X.
                88 SalAndCommiss Value "C".
                88 Hourly Value "H".
                88 Salary Value "S".
				
             05 :prefix:Pay         PIC 9(7)V99.
			 
             05 :prefix:HrsPerWeek  PIC 99V99.
			 
             05 :prefix:ComissRate  PIC V999.
			 
             05 :prefix:SalesAmount PIC 9(7)V99.
			 
             05 :prefix:HrsWorked   PIC 99V99.
			 
             05 :prefix:TimeCard    PIC 9(8).
            
            