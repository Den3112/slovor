import { describe, it, expect } from "vitest"
import { createClient } from "@/lib/supabase/client"

describe("Supabase Client", () => {
  it("creates client instance", () => {
    const supabase = createClient()
    expect(supabase).toBeDefined()
    expect(supabase.auth).toBeDefined()
  })

  it("has required methods", () => {
    const supabase = createClient()
    expect(typeof supabase.from).toBe("function")
    expect(typeof supabase.auth.getSession).toBe("function")
  })
})
