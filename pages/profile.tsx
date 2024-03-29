import React from "react";
import { useUser } from "@auth0/nextjs-auth0";
import Image from "next/image";

export default function Profile() {
    const { user, error, isLoading } = useUser();

    console.log(user);

    if (isLoading) return <div>Loading...</div>;
    if (error) return <div>{error.message}</div>;

    if (!user) return <h1>No Profile</h1>;

    return (
        user && (
            <div>
                <img src={user?.picture!} alt={user?.name!} />
                <h2>{user?.name}</h2>
                <p>{user?.email}</p>
            </div>
        )
    );
}
