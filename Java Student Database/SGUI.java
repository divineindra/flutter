/** This Java Program generates a GUI based application for
   
    
    using Swing and OOP concepts of Java language 
   
     @author Aditya Pandey
     Java Programming CSE 208

*/

import javax.swing.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.awt.*;
import java.util.*;
 
class Student 
{ int regno;
  String name,gen,branch,address;
  String email,dob,cca,yos,degr,hobby;

  Student(int regno,String name,String gen,String branch,String address,String email,String dob,String cca,String yos,String degr,String hobby)
     {  this.regno=regno;
        this.name=name;
        this.gen=gen;
        this.branch=branch;
        this.address=address;
        this.email=email;
        this.dob=dob;
        this.cca=cca;
        this.yos=yos;
        this.degr=degr;
        this.hobby=hobby;
     }
   
  
   }

   
    class DOB
  {   String day,mnth,year;
    DOB(String day,String mnth,String year)
     { this.day=day;
       this.mnth=mnth;
       this.year=year;
     }
  
  }





  public class SGUI extends JFrame implements  ActionListener, ItemListener
   
     {   DOB D[]= new DOB[10];
         Student SS[]=new Student[10];
         static int count=0;
         ArrayList<Student> list= new ArrayList<Student>(); 
         ArrayList<DOB> list2= new ArrayList<DOB>(); 
         JTextField t1,t2,t3;
         JTextArea ta;
         JRadioButton r1,r2;
         JComboBox cb,cc,cd,ce,cf,cg;
         JCheckBox c1,c2,c3;
         //JList la1;
         JScrollPane sp;
         JButton b1,b2,b3,b4,b5,b6,b7,b8;
         JLabel l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12;
          ButtonGroup bg1,bg;
          String j;
            String k=null; 
           String i=null;
         
          
         
          String[] la= {"Tennis", "Cricket", "BasketBall", "Soccer", "Hockey","Rugby", "Hand Ball", "Atheletics", "Chess", "Badminton"};
            JList<String> la1 = new JList<String>(la);
         SGUI()
       { 
          JFrame frame = new JFrame("Response Form");        
          
          frame.setLayout(new FlowLayout(FlowLayout.CENTER)); 




          t1= new JTextField(15);
          t2= new JTextField(15);
          t3= new JTextField(30);  
          ta= new JTextArea("",5,30);
         
     
          r1= new JRadioButton("Male");
          r2= new JRadioButton("Female");
           r1.addActionListener(this);
           r2.addActionListener(this);
           bg= new ButtonGroup();
          bg.add(r1); bg.add(r2);

          String sb[]={"B.Tech","BSc","M.Tech"}; 
          String sc[]={"CSE","IT","ICT","ECE"};
          String sd[]={"I","II","III","IV"};
          String se[]= new String[31];
           for(int j=0;j<31;j++)
            se[j]=new String(""+(j+1));
        
         String sf[]={"Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"};
         String sg[]= new String[30];
           for(int i=0;i<30;i++)
            sg[i]=new String(""+(i+1980));
   
         cb=new JComboBox<String>(sb);
         cc=new JComboBox<String>(sc);
	 cd=new JComboBox<String>(sd);
	 ce=new JComboBox<String>(se);
	 cf=new JComboBox<String>(sf);
	 cg=new JComboBox<String>(sg);
     
         cb.addActionListener(this);
         cc.addActionListener(this);
 	 cd.addActionListener(this);
 	 ce.addActionListener(this);
 	 cf.addActionListener(this);
 	 cg.addActionListener(this);
 	 
         
        c1=new JCheckBox("Stamp Collection");    
        c2=new JCheckBox("Reading Novels");    
        c3=new JCheckBox("Playing Tennis");  
         bg1= new ButtonGroup();
           bg1.add(c1); bg1.add(c2); bg1.add(c3); 
   
        c1.addItemListener(this);
        c2.addItemListener(this);
        c3.addItemListener(this);

      
      
      la1.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);     
      la1.addListSelectionListener(new ListSelectionListener()
       {
         public void valueChanged(ListSelectionEvent e) 
         { 
            int index=la1.getSelectedIndex();
	      if(index!=-1)
           j=(String)la1.getSelectedValue();
           
           
           
          }

 
  
             });

      sp = new JScrollPane(la1);
      
      b1= new JButton("ADD");
      b2= new JButton("SEARCH");
      b3= new JButton("DELETE");
      b4= new JButton("<<");
      b5= new JButton("<");
      b6= new JButton(">");
      b7= new JButton(">>");
      b8= new JButton("UPDATE");
   
      b1.addActionListener(this);
      b2.addActionListener(this);
      b3.addActionListener(this);
      b4.addActionListener(this);
      b5.addActionListener(this);
      b6.addActionListener(this);
      b7.addActionListener(this);
      b8.addActionListener(this);
     
     l1=new JLabel("Register No.");
     l2=new JLabel("Name");
     l3=new JLabel("Gender");
     l4=new JLabel("Degree");
     l5=new JLabel("Branch");
     l6=new JLabel("Year Of Study");
     l7=new JLabel("Date Of Birth");
     l8=new JLabel("E-mail Id");
     l9=new JLabel("Hobby");
     l10=new JLabel("Address");
     l11=new JLabel("Extra Curricular Activities");
     l12=new JLabel("Student Response Form");

  
   frame.add(l1);   frame.add(t1);     frame.add(l9);   frame.add(c1);   frame.add(c2);   frame.add(c3);           
   frame.add(l2);   frame.add(t2);     frame.add(l3);   frame.add(r1);   frame.add(r2); 
    
   frame.add(l4);    frame.add(cb); 
   frame.add(l5);    frame.add(cc); 
   frame.add(l6);    frame.add(cd);
   frame.add(l7);   frame.add(ce);   frame.add(cf);   frame.add(cg); 
   frame.add(l8);   frame.add(t3);
  
   frame.add(l10);   frame.add(ta);
   frame.add(l11);   frame.add(sp);
   frame.add(b1);   frame.add(b2);   frame.add(b3);   frame.add(b4);   frame.add(b5);   frame.add(b6);   frame.add(b7);   frame.add(b8);  

  
    frame.setVisible(true);
    frame.setSize(500,500);          
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

  }
   
   void insert()
  {  String b,c,d,e,f,g,h;
     int a=0;
     
   
 
   try{
         if(t1.getText()==null)
            t1.setText("Value not found");
      else
     a=Integer.parseInt(t1.getText());

     b=t2.getText();
     c=t3.getText();
     d=cb.getSelectedItem().toString();
     e=cc.getSelectedItem().toString();
     f=cd.getSelectedItem().toString();
 
     g=ce.getSelectedItem().toString()+cf.getSelectedItem().toString()+cg.getSelectedItem().toString();
     D[count]=new DOB(ce.getSelectedItem().toString(),cf.getSelectedItem().toString(),cg.getSelectedItem().toString());
     list2.add(new DOB(ce.getSelectedItem().toString(),cf.getSelectedItem().toString(),cg.getSelectedItem().toString()));
     h=ta.getText();
     //i=bg.getSelection().getActionCommand();

      
     if(i==null)
       t2.setText("Update Gender Again");
    if(k==null)
      t1.setText(" Update Hobby again");
    
   // k=bg1.getSelection().getActionCommand();

    list.add(new Student(a,b,i,e,h,c,g,j,f,d,k));
     SS[count++]= new Student(a,b,i,e,h,c,g,j,f,d,k);
     
    clear();
  
   } catch(Exception x){ System.out.println(x);
                          t1.setText("Enter Only Number");}
     
   }
    
  void search()
  { 
      try{
  
   int a=Integer.parseInt(t1.getText());
  
 
     for( Student s:list)
       { if(s.regno==a)
          display(list.indexOf(s));
         
        }
   
    // clear();
     //t1.setText("Not Found");

    }catch(Exception x){ System.out.println(x);
                       t1.setText("No record or Regno");
                      
                     }
  

   }
 
   void delete()
  { 
    try{

   int a=Integer.parseInt(t1.getText());
   
   Iterator<Student> itr= list.iterator();
      while(itr.hasNext())
       {   Student s=itr.next();
       if(s.regno==a)
         { itr.remove();
           count--;
           t2.setText("Record Deleted");
       }
       }
     
   clear();

   }catch(Exception x){ System.out.println(x);
                       t1.setText("No RegNo or record "); 
                     }
  
  
    }
  
   void update()
 {  
   String b,c,d,e,f,g,h;
    int cnt=0;
   
   try{
           int a=Integer.parseInt(t1.getText());
   
       for(Student s:list)
       { 
          if(s.regno==a)
          {  cnt=list.indexOf(s);
        
     b=t2.getText();
     c=t3.getText();
     d=cb.getSelectedItem().toString();
     e=cc.getSelectedItem().toString();
     f=cd.getSelectedItem().toString();
     D[cnt]=null;
     SS[cnt]=null;
     g=ce.getSelectedItem().toString()+cf.getSelectedItem().toString()+cg.getSelectedItem().toString();
     D[cnt]=new DOB(ce.getSelectedItem().toString(),cf.getSelectedItem().toString(),cg.getSelectedItem().toString());
     list2.set(cnt,D[cnt]);
     h=ta.getText();
     //i=bg.getSelection().getActionCommand();
     //k=bg1.getSelection().getActionCommand();

   
     SS[cnt]= new Student(a,b,i,e,h,c,g,j,f,d,k);
      list.set(cnt,SS[cnt]);
  
     } 
     }
   clear();
    
  }catch(Exception x){ System.out.println(x);
                       t2.setText("No Valid Data");
                     }
        
  }

  void clear()
  { 
     t1.setText("");
     t2.setText("");
     t3.setText("");
    
     bg.clearSelection();
     bg1.clearSelection();
     cb.setSelectedIndex(-1);
     cc.setSelectedIndex(-1);
     cd.setSelectedIndex(-1);
     ce.setSelectedIndex(-1);
     cf.setSelectedIndex(-1);
     cg.setSelectedIndex(-1);
     ta.setText("");
     la1.clearSelection();
   
   }




 
  void display(int cnt)
 { 

   
  k=null;
  i=null;
      try{
   Student a= list.get(cnt);
   DOB     o=list2.get(cnt);
   t1.setText(Integer.toString(a.regno));
   t2.setText(a.name);
   t3.setText(a.email);
   ta.setText(a.address);
   String b,c,d,e,f,g,l,m;
   String N;
    N=a.cca;
  
      if(N!=null)
        { 
          for(int w=0;w<10;w++)
            {if(la[w].equals(N))
               la1.setSelectedIndex(w);}
        }

     
   b=a.degr;
   c=a.branch;
   d=a.yos;
   e=o.day;
   f=o.mnth;
   g=o.year;
     Object B=b;
     Object C=c;
     Object D=d;
     Object E=e;
     Object F=f;
     Object G=g;
     m=a.hobby;
     l=a.gen;

       if(m!=null)
      {
     if(m.equals("Stamp Collection"))
        c1.setSelected(true);
     else if(m.equals("Reading Novels"))
        c2.setSelected(true);
     else if(m.equals("Playing Tennis"))
        c3.setSelected(true);
    
       }
   
   
        
     cb.setSelectedItem(B);
     cc.setSelectedItem(C);
     cd.setSelectedItem(D);
     ce.setSelectedItem(E);
     cf.setSelectedItem(F);
     cg.setSelectedItem(G);
     
       if(l!=null)
      {
     if(l.equals("Male"))
        r1.setSelected(true);
     else if(l.equals("Female"))
       r2.setSelected(true);
     }

   
   
  

  }catch(Exception x){ System.out.println(x);
                       t2.setText("No initial or Final record");
                     }
}


  void displayp()
  { 
     try{
     int a=Integer.parseInt(t1.getText());
     int b;
   for( Student s:list)
     if(s.regno==a)
       { b=list.indexOf(s)-1;
         if(b> -1)
        display(b);
       }


  }catch(Exception x){ System.out.println(x);
                       t1.setText("No record Error"); 
                     }
  
 }



      void displayn()
  {
     try{
     int a=Integer.parseInt(t1.getText());
     int b;
   for( Student s:list)
     if(s.regno==a)
       { b=list.indexOf(s)+1;
         if(b<10)
        display(b);
       }

   }catch(Exception x){ System.out.println(x);
                       t1.setText("No record Error"); 
                     }
  

   }
 


    public void actionPerformed(ActionEvent e)
      {
            if(e.getSource()==b1)
                insert();
             if(e.getSource()==b2)
                search();
              if(e.getSource()==b3)
               delete();
             if(e.getSource()==b4)
                display(0);
              if(e.getSource()==b5)
                displayp();
             if(e.getSource()==b6)
               displayn();
              if(e.getSource()==b7)
                display(count-1); 
             if(e.getSource()==b8)
                update();
             if(e.getSource()==r1)
                i=r1.getText();
             if(e.getSource()==r2)
                i=r2.getText();
              
       }
  

   public void itemStateChanged(ItemEvent e)
       {      
           JCheckBox t=(JCheckBox)e.getItem();
		if(t.isSelected())
                   k=t.getText();
		   
                      
        }

 public static void main(String args[])
   { 
      
                 try { 
      UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
             } 
        catch (Exception e) { 
            System.out.println("Look and Feel not set"); 
        } 

         SGUI g= new SGUI();     

  }

  
}


