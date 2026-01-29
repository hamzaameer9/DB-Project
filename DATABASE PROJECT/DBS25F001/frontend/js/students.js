async function loadStudents() {
    try {
        const res = await fetch(`${API_BASE}/students`);
        const data = await res.json();

        const tbody = document.getElementById("studentsBody");
        tbody.innerHTML = "";

        data.forEach(s => {
            tbody.innerHTML += `
                <tr>
                    <td>${s.student_id}</td>
                    <td>${s.name}</td>
                    <td>${s.roll_no}</td>
                    <td>${s.class_name}</td>
                    <td>${s.section_name}</td>
                    <td>${s.status}</td>
                </tr>
            `;
        });

    } catch (e) {
        alert("Backend not connected");
        console.error(e);
    }
}

loadStudents();
