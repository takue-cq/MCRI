# Matter Backend API

Backend API for the Matter student management application.

## Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn

### Installation

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

### Running the Server

#### Development Mode (with auto-reload):
```bash
npm run dev
```

#### Production Mode:
```bash
npm start
```

The server will start on port 3000 by default.

## API Endpoints

### Students

- `GET /api/students` - Get all students
- `GET /api/students/cohort/:cohort` - Get students by cohort number
- `GET /api/students/:id` - Get a specific student by ID
- `POST /api/students` - Create a new student
- `PUT /api/students/:id` - Update an existing student
- `DELETE /api/students/:id` - Delete a student

### Data Storage

Student data is stored in `backend/data/students.json`. The data directory is automatically created on first run.

## Configuration

### Port Configuration

To change the default port, set the `PORT` environment variable:

```bash
PORT=8080 npm start
```

### iOS App Configuration

Update the `baseURL` in `Matter/MatterApp-3/APIConfig.swift` to match your server address:

- **Local Development**: `http://localhost:3000`
- **Network Testing**: Use your computer's IP address (e.g., `http://192.168.1.X:3000`)
- **Production**: Your deployed server URL

## Example Requests

### Get All Students
```bash
curl http://localhost:3000/api/students
```

### Get Students by Cohort
```bash
curl http://localhost:3000/api/students/cohort/1
```

### Create Student
```bash
curl -X POST http://localhost:3000/api/students \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "imageName": "person.crop.circle.fill",
    "email": "john@example.com",
    "bio": "Student bio",
    "skills": ["Swift", "SwiftUI"],
    "cohort": 1,
    "phase": 1,
    "gender": "Male",
    "funFact": "Fun fact here"
  }'
```

### Update Student
```bash
curl -X PUT http://localhost:3000/api/students/{id} \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Updated",
    "email": "john.updated@example.com"
  }'
```

### Delete Student
```bash
curl -X DELETE http://localhost:3000/api/students/{id}
```

## Git Integration

This backend is designed to be part of your git repository. The `.gitignore` file excludes:
- `node_modules/` - Dependencies
- `data/` - Runtime data (optional - remove if you want to version control data)
- `.env` - Environment variables
- `.DS_Store` - macOS system files

## Troubleshooting

### Port Already in Use
If port 3000 is already in use, either:
1. Stop the process using port 3000
2. Use a different port: `PORT=3001 npm start`

### CORS Issues
The server includes CORS middleware. If you encounter CORS issues, ensure your iOS app's APIConfig.swift has the correct URL.

### Data Not Persisting
Ensure the `backend/data/` directory has write permissions.
