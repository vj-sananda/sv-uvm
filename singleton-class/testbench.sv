//----------------------------------------------------
//Singleton class
//----------------------------------------------------

`include "uvm_macros.svh"

class JustMe ;
  
  local static JustMe m_justme;
  local static int id = 0;
  
  local function new();
	id++;
  endfunction
  
  function string sprint();
    return $psprintf("JUSTME::%d",id);
  endfunction
  
  static function JustMe create();
    if (m_justme == null) 
      m_justme = new ();
    return m_justme;
  endfunction
endclass

module tb ;
  
  import uvm_pkg::*;
  
  class mytest extends uvm_test ;

    string msg ;
    JustMe justme_inst[5];
    
    JustMe justme_hash[JustMe];
    
    int lindex[5] = '{0,1,2,3,4};
    
    const int a = 5;//creates immutable integer a, cannot be re-assigned anywhere.
    
    `uvm_component_utils(mytest)
    
    function new (string name, uvm_component parent);
      super.new(name,parent);
      msg = "Hello-World";
    endfunction
    
    task run_phase(uvm_phase phase);
      uvm_config_db#(string)::get(this,"","message",msg);
      `uvm_info("DEMO", msg, UVM_NONE)
            
      foreach(lindex[i]) begin
        //justme_inst[i] = new();won't compile, since new() is declared local
        justme_inst[i] = JustMe::create();
        `uvm_info("DEMO", justme_inst[i].sprint(), UVM_NONE)
      end
      
    endtask
    
  endclass
  
  initial
    run_test("mytest");
  
endmodule