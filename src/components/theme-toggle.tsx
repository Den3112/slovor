'use client';

import { useEffect, useState } from "react";

type Theme = "light" | "dark";

const THEME_KEY = "slovor-theme";

/**
 * Validate and return a safe theme value.
 * Ensures the value is either "light" or "dark".
 */
function validateTheme(value: unknown): Theme {
  if (value === "dark" || value === "light") {
    return value;
  }
  return "light";
}

export function ThemeToggle() {
  const [theme, setTheme] = useState<Theme>(() => {
    if (typeof window === "undefined") {
      return "light";
    }

    const stored = window.localStorage.getItem(THEME_KEY);
    if (stored) {
      return validateTheme(stored);
    }

    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light";
  });

  const applyTheme = (value: Theme) => {
    document.documentElement.classList.toggle("dark", value === "dark");
    window.localStorage.setItem(THEME_KEY, value);
  };

  useEffect(() => {
    if (typeof document === "undefined") {
      return;
    }
    applyTheme(theme);
  }, [theme]);

  const toggleTheme = () => {
    const nextTheme: Theme = theme === "dark" ? "light" : "dark";
    setTheme(nextTheme);
  };

  return (
    <button
      type="button"
      onClick={toggleTheme}
      className="rounded-full border border-slate-300 px-4 py-1 text-sm font-medium text-slate-700 transition hover:border-brand hover:text-brand dark:border-slate-600 dark:text-slate-200 dark:hover:border-brand-light dark:hover:text-brand-light"
      aria-label="Toggle theme"
    >
      {theme === "dark" ? "Dark" : "Light"}
    </button>
  );
}

