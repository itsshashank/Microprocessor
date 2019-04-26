// FTP Client

import java.net.*;
import java.io.*;
import java.util.*;


class FTPClient
{
    public static void main(String args[]) throws Exception
    {
        Socket soc=new Socket("127.0.0.1",1234);
        transferfileClient t=new transferfileClient(soc);
        t.displayMenu();
        
    }
}
class transferfileClient
{
    Socket ClientSoc;

    DataInputStream din;
    DataOutputStream dout;
    BufferedReader br;
    transferfileClient(Socket soc)
    {
        try
        {
            ClientSoc=soc;
            din=new DataInputStream(ClientSoc.getInputStream());
            dout=new DataOutputStream(ClientSoc.getOutputStream());
            br=new BufferedReader(new InputStreamReader(System.in));
        }
        catch(Exception ex)
        {
        }        
    }
    void SendFile() throws Exception
    {        
        
        String filename;
        System.out.print("Enter File Name :");
        filename=br.readLine();
            
        File f=new File(filename);
        if(!f.exists())
        {
            System.out.println("File not Exists...");
            dout.writeUTF("File not found");
            return;
        }
        
            System.out.println("Receiving File ...");
            //File f=new File(fileName);
            if(f.exists())
            {
                String Option;
                System.out.println("File Already Exists. Want to OverWrite (Y/N) ?");
                Option=br.readLine();            
                if(Option=="N")    
                {
                    dout.flush();
                    return;    
                }                
            }
            FileOutputStream fout=new FileOutputStream(f);
            int ch;
            String temp;
            do
            {
                temp=din.readUTF();
                ch=Integer.parseInt(temp);
                if(ch!=-1)
                {
                    fout.write(ch);                    
                }
            }while(ch!=-1);
            fout.close();
            System.out.println(din.readUTF());
                
        }
    public void displayMenu() throws Exception
    {
        while(true)
        {    
            System.out.println("FTP MENU ");
            System.out.println("1. Send File");
            System.out.println("2. Receive File");
            System.out.println("3. Exit");
            System.out.print("\nEnter Choice :");
            int choice;
            choice=Integer.parseInt(br.readLine());
            if(choice==1)
            {
                dout.writeUTF("SEND");
                SendFile();
            }
            else if(choice==2)
            {
                dout.writeUTF("GET");
                ReceiveFile();
            }
            else
            {
                dout.writeUTF("DISCONNECT");
                System.exit(1);
            }
        }
    }
	void ReceiveFile() throws Exception
    {
        String filename=din.readUTF();
        if(filename.compareTo("File not found")==0)
        {
            return;
        }
        File f=new File(filename);
        String option;
        
        if(f.exists())
        {
            dout.writeUTF("File Already Exists");
            option=din.readUTF();
        }
        else
        {
            dout.writeUTF("SendFile");
            option="Y";
        }
            
            if(option.compareTo("Y")==0)
            {
                FileOutputStream fout=new FileOutputStream(f);
                int ch;
                String temp;
                do
                {
                    temp=din.readUTF();
                    ch=Integer.parseInt(temp);
                    if(ch!=-1)
                    {
                        fout.write(ch);                    
                    }
                }while(ch!=-1);
                fout.close();
                dout.writeUTF("File Send Successfully");
            }
            else
            {
                return;
            }
            
    }
	 public void run()
    {
        while(true)
        {
            try
            {
            System.out.println("Waiting for Command ...");
            String Command=din.readUTF();
            if(Command.compareTo("GET")==0)
            {
                System.out.println("\tGET Command Received ...");
                SendFile();
                continue;
            }
            else if(Command.compareTo("SEND")==0)
            {
                System.out.println("\tSEND Command Receiced ...");                
                ReceiveFile();
                continue;
            }
            else if(Command.compareTo("DISCONNECT")==0)
            {
                System.out.println("\tDisconnect Command Received ...");
                System.exit(1);
            }
            }
            catch(Exception ex)
            {
            }
        }
    }
}
