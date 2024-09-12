// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    struct Task {
        string description;
        bool TaskStatus;
        uint priority;
    }

    Task[] private tasks;

    function _taskExists(uint _index) internal view returns (bool) {
        if (_index < tasks.length) {
            return true;
        } 
        else {
            return false;
        }
    }    

    function addTask(string calldata _description, uint _priority) external {
        if (_priority >= 1 && _priority <= 3) {
            tasks.push(Task(_description, false, _priority));
        } else {
            revert("Invalid priority. It must be between 1 and 3.");
        }
    }

    function markTaskDone(uint _index) external {
        _taskExists(_index);  
        tasks[_index].TaskStatus = true;
    }

    function removeTask(uint _index) external {
        if (_taskExists(_index)) {
            uint lastIndex = tasks.length - 1;
            if (_index != lastIndex) {
                tasks[_index] = tasks[lastIndex]; 
            }
            tasks.pop(); 
        } else {
            revert("Task does not exist.");
        }
    }

    function editTask(uint _index, string calldata _newDescription) external {
        if (_taskExists(_index)) {
            tasks[_index].description = _newDescription;
        } 
        else {
            revert("Task does not exist.");
        }
    }

    function sortTasksByPriority() external {
        uint len = tasks.length;
        for (uint i = 0; i < len - 1; i++) {
            for (uint j = 0; j < len - i - 1; j++) {
                if (tasks[j].priority > tasks[j + 1].priority) {
                    Task memory temp = tasks[j];
                    tasks[j] = tasks[j + 1];
                    tasks[j + 1] = temp;

                }
            }
        }
    }

    function getTasks() external view returns (Task[] memory) {
        return tasks;
    }
}
