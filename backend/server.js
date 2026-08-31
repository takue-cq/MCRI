const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;
const DATA_FILE = path.join(__dirname, 'data', 'students.json');

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Ensure data directory exists
const dataDir = path.join(__dirname, 'data');
if (!fs.existsSync(dataDir)) {
    fs.mkdirSync(dataDir);
}

// Initialize data file if it doesn't exist
if (!fs.existsSync(DATA_FILE)) {
    const initialData = [];
    fs.writeFileSync(DATA_FILE, JSON.stringify(initialData, null, 2));
}

// Helper functions
const readStudents = () => {
    const data = fs.readFileSync(DATA_FILE, 'utf8');
    return JSON.parse(data);
};

const writeStudents = (students) => {
    fs.writeFileSync(DATA_FILE, JSON.stringify(students, null, 2));
};

// API Routes

// GET all students
app.get('/api/students', (req, res) => {
    try {
        const students = readStudents();
        res.json(students);
    } catch (error) {
        res.status(500).json({ error: 'Failed to read students' });
    }
});

// GET students by cohort
app.get('/api/students/cohort/:cohort', (req, res) => {
    try {
        const cohort = parseInt(req.params.cohort);
        const students = readStudents();
        const filtered = students.filter(s => s.cohort === cohort);
        res.json(filtered);
    } catch (error) {
        res.status(500).json({ error: 'Failed to get students by cohort' });
    }
});

// GET single student by ID
app.get('/api/students/:id', (req, res) => {
    try {
        const id = req.params.id;
        const students = readStudents();
        const student = students.find(s => s.id === id);
        if (student) {
            res.json(student);
        } else {
            res.status(404).json({ error: 'Student not found' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Failed to get student' });
    }
});

// POST create new student
app.post('/api/students', (req, res) => {
    try {
        const students = readStudents();
        const newStudent = {
            id: generateUUID(),
            ...req.body
        };
        students.push(newStudent);
        writeStudents(students);
        res.status(201).json(newStudent);
    } catch (error) {
        res.status(500).json({ error: 'Failed to create student' });
    }
});

// PUT update student
app.put('/api/students/:id', (req, res) => {
    try {
        const id = req.params.id;
        const students = readStudents();
        const index = students.findIndex(s => s.id === id);
        
        if (index !== -1) {
            students[index] = { ...students[index], ...req.body };
            writeStudents(students);
            res.json(students[index]);
        } else {
            res.status(404).json({ error: 'Student not found' });
        }
    } catch (error) {
        res.status(500).json({ error: 'Failed to update student' });
    }
});

// DELETE student
app.delete('/api/students/:id', (req, res) => {
    try {
        const id = req.params.id;
        const students = readStudents();
        const filtered = students.filter(s => s.id !== id);
        writeStudents(filtered);
        res.json({ message: 'Student deleted successfully' });
    } catch (error) {
        res.status(500).json({ error: 'Failed to delete student' });
    }
});

// Helper function to generate UUID
function generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        const r = Math.random() * 16 | 0;
        const v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

// Start server
app.listen(PORT, () => {
    console.log(`Matter Backend API running on port ${PORT}`);
});
