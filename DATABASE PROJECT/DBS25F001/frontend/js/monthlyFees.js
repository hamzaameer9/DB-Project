async function loadFees() {
    try {
        const res = await fetch(`${API_BASE}/monthly-fees`);
        const data = await res.json();

        const body = document.getElementById("feeBody");
        body.innerHTML = "";

        data.forEach(f => {
            body.innerHTML += `
                <tr>
                    <td>${f.monthly_fee_id}</td>
                    <td>${f.student_id}</td>
                    <td>${f.month}</td>
                    <td>${f.amount}</td>
                    <td>${f.due_date}</td>
                    <td>${f.status}</td>
                </tr>
            `;
        });

    } catch (err) {
        alert("Backend not connected");
        console.error(err);
    }
}

loadFees();
