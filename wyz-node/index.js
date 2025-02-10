const express = require("express");
const app = express();

const formData = {
  formTitle: "User Registration",
  fields: [
    {
      id: 1,
      type: "textbox",
      label: "Full Name",
      placeholder: "Enter your full name",
      color: "#000000",
      size: "medium",
      index: 1,
      validation: {
        required: true,
        minLength: 3,
        maxLength: 50,
        pattern: "^[a-zA-Z ]+$",
        errorMessage: "Please enter a valid name (only letters and spaces).",
      },
    },
    {
      id: 2,
      type: "dropdown",
      label: "Country",
      options: ["USA", "India", "Canada"],
      color: "#FF5733",
      size: "large",
      index: 2,
      validation: {
        required: true,
        errorMessage: "Please select a country.",
      },
    },
    {
      id: 6,
      type: "checkbox",
      label: "Accept Terms & Conditions",
      color: "#008000",
      size: "small",
      index: 6,
      validation: {
        required: true,
        errorMessage: "You must accept the Terms & Conditions.",
      },
    },
    {
      id: 4,
      type: "slider",
      label: "Age",
      min: 18,
      max: 100,
      color: "#1E90FF",
      size: "medium",
      index: 4,
      validation: {
        required: true,
        errorMessage: "Please select a valid age between 18 and 100.",
      },
    },
    {
      id: 5,
      type: "radio",
      label: "Gender",
      options: ["Male", "Female", "Other"],
      color: "#FF1493",
      size: "medium",
      index: 5,
      validation: {
        required: true,
        errorMessage: "Please select a gender.",
      },
    },
    {
      id: 3,
      type: "date",
      label: "Date of Birth",
      placeholder: "Select your date of birth",
      color: "#800080",
      size: "medium",
      index: 3,
      validation: {
        required: true,
        errorMessage: "Please select a valid date of birth.",
      },
    },
  ],
};
app.get("/api/form", (req, res) => {
  res.json(formData);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
