fetch(API + "/students")
    .then(res => res.json())
    .then(students => {

        document.getElementById("totalStudents").innerText =
            students.length;

        let paid = 0;
        let unpaid = 0;

        students.forEach(s => {
            if (s.status === "PAID") paid++;
            else unpaid++;
        });

        document.getElementById("paidStudents").innerText = paid;
        document.getElementById("unpaidStudents").innerText = unpaid;
    });
