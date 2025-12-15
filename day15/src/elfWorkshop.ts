export class ElfWorkshop {
    // You could create a constructor to allow the user to direcly initialise the task list.
    taskList: string[] = [];

    // It would be great if this function indicates if the operation was done or not. 
    // It could return a bool for instance.     
    addTask(task: string): void {
        // You should make a clausing gard instead.
        if (task !== "") {
            this.taskList.push(task);
        }
    }
    
    // The function's name should indicate more precisely what it is expected to do. 
    // You should return an optional / a result instead of the null pointer.
    completeTask(): string {
        // You should make a clausing gard instead.
        if (this.taskList.length > 0) {
            return this.taskList.shift();
        }
        return null;
    }
}