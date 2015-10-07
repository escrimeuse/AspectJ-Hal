import java.io.*;

public aspect Logger {
	
	BufferedWriter fileoutput;
	
	pointcut crewMessages(Crew crew, OnBoardComputer computer) : this(crew) && target(computer) && within(Crew);
	pointcut lifeSupportMessages(Crew crew) : within(LifeSupport) && target(crew);
	pointcut authorizationMessages(Crew crew): within(Authorization) && target(crew);
	
	before(Crew crew, OnBoardComputer computer): crewMessages(crew, computer) {
		
		try {
			fileoutput = new BufferedWriter(new FileWriter("output.txt",true));
			if (thisJoinPoint.getKind().equals("method-call")){
				fileoutput.write(System.currentTimeMillis()%1000 + "");
				fileoutput.write(" : ");
				fileoutput.write("Crew");
				fileoutput.write(" : ");
				fileoutput.write(computer + "");
				fileoutput.write(" : ");
				fileoutput.write(thisJoinPoint.getSignature().getName() + "\n");
			}
			fileoutput.close();
		}
		catch (Exception e) {
			
		}
	
	}
	
	before(Crew crew): lifeSupportMessages(crew) {
		try {
			fileoutput = new BufferedWriter(new FileWriter("output.txt",true));
			if(thisJoinPoint.getKind().equals("method-call")) {
				fileoutput.write(System.currentTimeMillis()%1000 + "");
				fileoutput.write(" : ");
				fileoutput.write("LifeSupport");
				fileoutput.write(" : ");
				fileoutput.write(crew + "");
				fileoutput.write(" : ");
				fileoutput.write(thisJoinPoint.getSignature().getName() + "\n");
			}
			fileoutput.close();
		}
		catch(Exception e) {
			
		}
		

	}
	
	before(Crew crew): authorizationMessages(crew) {
		
		try {
			fileoutput = new BufferedWriter(new FileWriter("output.txt",true));
			if (thisJoinPoint.getSignature().getName().equals("kill")){
				fileoutput.write(System.currentTimeMillis()%1000 + "");
				fileoutput.write(" : ");
				fileoutput.write("Authorization");
				fileoutput.write(" : ");
				fileoutput.write(crew + "");
				fileoutput.write(" : ");
				fileoutput.write(thisJoinPoint.getSignature().getName() + "\n");
			}
			fileoutput.close();
		}
		catch (Exception e) {
			
		}
		
		
	}
}
	
	
				
			
			
			
		

	


