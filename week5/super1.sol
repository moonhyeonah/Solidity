// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Student {
    string[] internal courses; 
    function showCourses() public virtual returns(string[] memory) {
        delete courses;
        courses.push("English");
        courses.push("Music");
        return courses;
    }
        
    function deleteArray() public {
        delete courses;
    }
    
    function getArrayLength() public view returns(uint) {
        return courses.length;
    }
    function getArray() public view returns(string[] memory) {
        return courses;
    }
}