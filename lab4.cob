      
        Identification Division.
        Program-ID. lab4.
		
        *>     Tyler Zysberg
        *>    Program compute a payroll file
        
        Environment Division.
        Input-Output Section.
        File-Control.
            Select inFile Assign to "lab4-in.dat"
                Organization is Line Sequential.
                
            Select outReport Assign to "lab4-out.dat"
                Organization is Line Sequential.
                
        Data Division.
        File Section.
        FD inFile.
        Copy payroll replacing ==:prefix:== By ==in==.
        
        FD outReport.
        01 outRecord    PIC X(200).
        
        Working-Storage Section.
        
        01 eof PIC X Value "N".
		01 blankLine    PIC X Value Spaces.
        
        01 ReportStuff. 
            05 pageNum  PIC 999 Value 0.
            05 linesPerPage PIC 99 Value 35.
            05 lineNum  PIC 99 Value 36.
        
        01 ws-date.
            05 ws-yr    PIC 9(4).
            05 ws-mo    PIC 99.
            05 ws-dy    PIC 99.
            
        01 ws-time. 
            05 ws-hr    PIC 99.
            05 ws-mn    PIC 99.
            05 ws-sc    PIC 99.
            05 ws-cc    PIC 99.
        
        01 pageHeader.
            05 ph-Month PIC Z9/.
            05 ph-Day   PIC 99/.
            05 ph-Year  PIC 9999.
            05          PIC X(50) Value Spaces.
            05          PIC X(27) Value "Stomper & Wombat's Emporium".
            05          PIC X(50) Value Spaces.
			05          PIC X(5) value "Page:".
            05 ph-Page  PIC Z9.
            
        01 secondPageHeader.
            05          PIC XXX Value Spaces.
            05 ph-hr    PIC Z9.
            05          PIC X Value ":".
            05 ph-mn    PIC 99.
            05          PIC X Value Spaces.
            05 ph-ampm  PIC XX.
            05          PIC X(50) Value Spaces.
            05          PIC X(29) Value "Monthly Gross Payroll Listing".  
        
        01 columnHeader.
            05          PIC X(8) Value "Dep #".
            05          PIC X(17) Value "Emp #".
            05          PIC X(22) Value "Employee".
            05          PIC X(20) Value "Title".
            05          PIC X(10) Value "DOH".
            05          PIC X(9) Value "Marital".
            05          PIC X(7) Value "#Deps".
            05          PIC X(6) Value "Ins".
            05          PIC X(6) Value "401k".
            05          PIC X(6) Value "Pay".
            05          PIC X(13) Value "Expected Pay".
            05          PIC X(7) Value "   +   ".
            05          PIC X(10) Value "Commission".
        
        01 TotalDis.
            05            PIC X(100) Value Spaces.
            05            PIC X(26) Value "Total Expected Payroll".
            05 expPayroll PIC $$$$,$$$,$$9.99.
        
        01 OutputInfo.
			05 outDep   PIC X(5).
            05          PIC X(3) Value Spaces.
            05 outEmp   PIC X(5).
            05          PIC X(4) Value Spaces.
            05 outLastName  PIC X(20).
            05          PIC X Value Spaces.
            05 outFirstInitial PIC X.
            05          PIC XXX Value Spaces.
            05 outTitle PIC X(20).
            05          PIC X(2) Value Spaces.
            05 outDoHMonth PIC Z9/.
            05 outDoHDay  PIC 99/.
            05 outDoHYear PIC 9999.
            05          PIC X(6) Value Spaces.
            05 outMar   PIC X.
            05          PIC X(7) Value Spaces.
            05 outDeps  PIC Z9.
            05          PIC X(4) Value Spaces.
            05 outIns   PIC X(3).
            05          PIC X(3) Value Spaces.
            05 out401k  PIC 9.99.
            05          PIC XXX Value "%  ".
            05 outPayC  PIC X.
            05          PIC X(3) Value Spaces.
            05 outExPay PIC $$,$$$,$$9.99.
            05          PIC X(4) Value Spaces.
            05 outComis PIC X(13).
            
        01 Insurance. 
            05 medIns   PIC X.
            05 visIns   PIC X.
			05 denIns   PIC X.
        01 Total.
            05 totPay   PIC 9(9)V99.
			
        01 Calc401k  PIC 99V99. 
        01 DisplayComiss  PIC $$,$$$,$$9.99.
            
        Procedure Division.
        000-Main.
            Open input inFile
                output outReport
            Perform 200-getDate
            Perform until eof = "Y"
                Read inFile
                at end
                    Move "Y" to eof
                not at end
                    Perform 100-createReport
            End-Perform
            
         Perform 700-displayTotal
        
        Close inFile
        Close outReport
		
        Stop Run.
      * Creates report  
        100-createReport.
            If lineNum > linesPerPage 
                Perform 300-newPage
            End-If
            
            Perform 400-Record
            Write outRecord from OutputInfo. 
			
        200-getDate.
            accept ws-date from date YYYYMMDD
            accept ws-time from time
            
            Move ws-yr to ph-Year
            Move ws-mo to ph-Month
            Move ws-dy to ph-Day.
            Move ws-mn to ph-mn
          
            If ws-hr>=1 and < 13
                Move ws-hr to ph-hr
                Move "AM" to ph-ampm
            End-If
            If ws-hr <1 
                Add 12 to ws-hr
                Move ws-hr to ph-hr
                Move "AM" to ph-ampm
            End-If
            If ws-hr >= 13
                Compute ws-hr = ws-hr - 12
                Move ws-hr to ph-hr
                Move "PM" to ph-ampm
            End-If.
            
      
        300-newPage.
            If pageNum > 0
                Write outRecord from blankLine after advancing 1 line
            End-If
            Add 1 to pageNum
            Move pageNum to ph-Page
            
            Move 0 to lineNum
            Write outRecord from pageHeader after advancing page
            Add 1 to lineNum
			
            Write outRecord from secondPageHeader after advancing 1 line
            Add 1 to lineNum
			
            Write outRecord from blankLine after advancing 1 line
            Add 1 to lineNum
			
            Write outRecord from columnHeader after advancing 1 line
            Add 1 to lineNum
			
            Write outRecord from blankLine after advancing 1 line
            Add 1 to lineNum.
			
            Write outRecord from blankLine after advancing 1 line
            Add 1 to lineNum.
        
        400-Record.
            Move inDepNum to outDep
            Move inEmpNum to outEmp
            Move inLastName to outLastName
            Move inFirstName to outFirstInitial
            Move inJobTitle to outTitle
            Move inDoHYear to outDoHYear
            Move inDoHMonth to outDoHMonth
            Move inDoHDay to outDoHDay
            Move inMarital to outMar
            Move inDependents to outDeps
            
            If inMedical = "Y"
                Move "M" to medIns
            Else
                Move " " to medIns
            End-If
            If inDental = "Y"
                Move "D" to denIns
            Else
                Move " " to denIns
            End-If
            If inVision = "Y"
                Move "V" to visIns
            Else
                Move " " to visIns
            End-If
            
            String  denIns delimited by size
			        medIns delimited by size
                    visIns delimited by size into outIns
           
            Compute Calc401k = in401k * 100
			
            Move Calc401k to out401k
            Move inPayCode to outPayC
            
            Perform 600-calculatePay
            
            Add 1 to lineNum.
       
        600-calculatePay.
            If inPayCode = "S"
                Compute inPay rounded = inPay / 12
                Move inPay to outExPay
                Move Spaces to outComis
                Compute totPay = totPay + inPay
            End-If
			
            If inPayCode = "H"
                Compute inPay rounded = 52 * inPay / 12 * inHrsPerWeek
                Move inPay to outExPay
                Move Spaces to outComis
                Compute totPay = totPay + inPay
            End-If
			
            If inPayCode = "C"
                Compute inPay rounded = inPay / 12
                Move inPay to outExPay
                Compute inSalesAmount Rounded = inComissRate * 45000
                Move inSalesAmount to DisplayComiss
                Move DisplayComiss to outComis
                Compute totPay = totPay + inPay + inSalesAmount
            End-If.
        
        700-displayTotal.
            If lineNum > linesPerPage 
                Perform 300-newPage
            End-If
            Move totPay to expPayroll
            Write outRecord from TotalDis after advancing 1 line.
            
        