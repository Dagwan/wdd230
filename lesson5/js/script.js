
let input = document.querySelector('input');
let button = document.querySelector('button');
let list = document.querySelector('ul');


let closebtn = document.querySelector('.closebtn');


button.addEventListener('click', addFunction);

function addFunction() {
	let response = input.value;

	if (response == "") {
        var alert = document.getElementById("alert");
		alert.style.display = "block";
	} 
    else {
        
		const listElement = document.createElement('li');
       
		const deleteButton = document.createElement('button');

        
		listElement.textContent = response;
       
		deleteButton.textContent = "❌";
        
        deleteButton.setAttribute('aria-label', "Remove chapter.")
		
        
		listElement.append(deleteButton);
        
		list.append(listElement);	

       
		deleteButton.addEventListener('click', deleteFunction);

        function deleteFunction() {
            list.removeChild(listElement);
        }
        
	}

    input.focus();
	input.value = "";
    
};


closebtn.addEventListener('click', closeFunction);
function closeFunction() {
    this.parentElement.style.display='none';
}