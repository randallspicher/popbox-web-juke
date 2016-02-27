package nmt.utils;

public class FileItem {

	private boolean fileisfolder=false;
	private String filename="";
	private String filesizestring="";
	private long filesize=0;
	private String filetype="";

	public void setIsFolder(String newvalue){
		fileisfolder="yes".equalsIgnoreCase(newvalue);
	}
	public boolean getIsFolder(){
		return fileisfolder;
	}
	public void setName(String newvalue){
		filename=newvalue;
	}
	public String getName(){
		return filename;
	}
	public void setType(String newvalue){
		//System.out.println("type="+newvalue);
		filetype=newvalue;
	}
	public String getType(){
		return filetype;
	}

	public void setSize(long size){
		filesize=size;
	}
	public long getSize(){
		return filesize;
	}
}
