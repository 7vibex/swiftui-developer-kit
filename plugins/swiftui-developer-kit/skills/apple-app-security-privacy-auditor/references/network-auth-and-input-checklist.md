# Network, Authentication, And Input Checklist

## Network And Web Content

- Inventory hosts, API clients, `URLSession` delegates, web views, background transfers, WebSockets, and low-level network APIs.
- Review ATS configuration, global load exceptions, per-domain exceptions, insecure URLs, custom server trust, and certificate-expiry handling. Prefer server remediation and the narrowest exception.
- Check headers, query strings, request and response bodies, cache policy, redirects, redirects to external domains, and logs for sensitive data exposure.
- Treat certificate pinning as an optional threat-model decision with rotation and outage planning, not a universal requirement.

## Authentication And Sessions

- Locate sign-in, account recovery, OAuth or web-auth callbacks, token exchange, refresh, logout, account switch, revocation, and expired-session behavior.
- Check that redirect targets, callback schemes, state, PKCE, and callback parsing are validated when the app uses OAuth or web sign-in.
- Check whether tokens or session artifacts reach UserDefaults, files, logs, URL parameters, pasteboard, clipboard, analytics, widgets, or extensions.
- Confirm that UI state does not become the only authorization control; server-side authorization remains an evidence gap unless inspected.

## Deep Links, Imports, And External Actions

- Inventory custom URL schemes, universal links, `onOpenURL`, user activities, notification actions, share extensions, document imports, and external URL opening.
- Parse untrusted URLs and file metadata defensively; authorize the requested resource or action after parsing instead of trusting route components.
- Limit accepted hosts, schemes, file types, size, and lifecycle according to product needs. Use security-scoped access and cleanup correctly when the platform flow requires it.
- Check that web content and link previews do not receive credentials, private text, or user-controlled navigation without a clear boundary.
