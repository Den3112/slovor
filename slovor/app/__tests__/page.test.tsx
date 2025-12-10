import { render, screen } from "@testing-library/react"
import { describe, it, expect } from "vitest"
import HomePage from "../page"

describe("HomePage", () => {
  it("renders without crashing", () => {
    render(<HomePage />)
    expect(document.body).toBeInTheDocument()
  })

  it("displays main heading", () => {
    render(<HomePage />)
    const heading = screen.getByRole("heading", { level: 1 })
    expect(heading).toBeInTheDocument()
  })

  it("shows development status", () => {
    render(<HomePage />)
    expect(screen.getByText(/development/i)).toBeInTheDocument()
  })
})
