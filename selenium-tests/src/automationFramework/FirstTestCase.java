package automationFramework;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class FirstTestCase {

	public static void main(String[] args) throws InterruptedException {
		
		        String envurl = "http://dc-prod.demo-deloitte.com" ;
                String envtype = "PROD";
		        
		        // Create a new instance of the Firefox driver
		        System.setProperty("webdriver.gecko.driver","C:\\dc-2017\\geckodriver.exe");
				WebDriver driver = new FirefoxDriver();
				
		        //Launch the Online Store Website
				driver.get(envurl);
		 
		        
				  boolean Error = driver.getPageSource().contains("Deloitte OpenCloud");
				    if (Error == true)
				    {
				     System.out.print("Content Found - Deloitte OpenCloud\n");
				        // Close the driver
				        driver.quit();
				    }
				    else
				    {
				     System.out.print("Content Missing - Deloitte OpenCloud\n");
				        // Close the driver
				        driver.quit();
				     System.exit(1);
				    }
				    
				 // Print a Log In message to the screen
			        System.out.println("\nFunctional Testing Completed for the " + envtype + " environment: " + envurl);
			 
					//Wait for 5 Sec
					Thread.sleep(20);
	}

}
